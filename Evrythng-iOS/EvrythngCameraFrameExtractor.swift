//
//  EvrythngCameraFrameExtractor.swift
//  EvrythngiOS
//
//  Created by JD Castro on 17/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit
import AVFoundation

protocol EvrythngCameraFrameExtractorDelegate: class {
    func willStartCapture()
    func captured(uiImage image: UIImage, ciImage: CIImage)
    func captured2(value: String)
}

internal class EvrythngCameraFrameExtractor: NSObject {
    
    private let position = AVCaptureDevicePosition.back
    private let quality = AVCaptureSessionPresetMedium
    
    private var permissionGranted = false
    private let sessionQueue = DispatchQueue(label: "session queue")
    private let context = CIContext()
    
    let captureSession = AVCaptureSession()
    
    weak var delegate: EvrythngCameraFrameExtractorDelegate?
    
    override init() {
        super.init()
        checkPermission()
        self.configureSession()
        self.sessionQueue.async { [unowned self] in
            self.delegate?.willStartCapture()
            self.captureSession.startRunning()
        }
    }
    
    deinit {
        print("\(#function) EvrythngCameraFrameExtractor")
    }
    
    // MARK: AVSession configuration
    
    private func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .authorized:
            print("Camera Permission is Already Granted")
            permissionGranted = true
        case .notDetermined:
            print("Camera Permission Not Yet Determined.. Requesting Permission")
            requestPermission()
        default:
            print("Camera Permission Not Granted. We just cry :(")
            permissionGranted = false
        }
    }
    
    // MARK: Public Class Functions
    
    public func stopSession() {
        self.captureSession.stopRunning()
    }
    
    public func resumeSessionQueue() {
        self.sessionQueue.resume()
    }
    
    public func pauseSessionQueue() {
        self.sessionQueue.suspend()
    }
    
    // MARK: Private Class Functions
    
    private func requestPermission() {
        self.sessionQueue.suspend()
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { [unowned self] granted in
            if(granted) {
                print("Camera Permission is now Granted!. Woohoo! :)")
            } else {
                print("Camera Permission has been denied!. Ouch! :(")
            }
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
    }
    
    private func configureSession() {
        guard self.permissionGranted else { return }
        self.captureSession.sessionPreset = quality
        guard let captureDevice = selectCaptureDevice() else { return }
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        guard self.captureSession.canAddInput(captureDeviceInput) else { return }
        self.captureSession.addInput(captureDeviceInput)
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer"))
        guard self.captureSession.canAddOutput(videoOutput) else { return }
        self.captureSession.addOutput(videoOutput)
        guard let connection = videoOutput.connection(withMediaType: AVFoundation.AVMediaTypeVideo) else { return }
        guard connection.isVideoOrientationSupported else { return }
        guard connection.isVideoMirroringSupported else { return }
        connection.videoOrientation = .portrait
        connection.isVideoMirrored = position == .front

        // READ BARCODES
        
        let metaDataOutput = AVCaptureMetadataOutput()
        metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.global())
        self.captureSession.addOutput(metaDataOutput)
        metaDataOutput.metadataObjectTypes = metaDataOutput.availableMetadataObjectTypes
        
        print("Configure Session Successful")
    }
    
    private func selectCaptureDevice() -> AVCaptureDevice? {
        return AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: position).devices.first
        /*
        return AVCaptureDevice.devices().filter {
            ($0 as AnyObject).hasMediaType(AVMediaTypeVideo) &&
                ($0 as AnyObject).position == position
            }.first as? AVCaptureDevice
         */
    }
    
    // MARK: Sample buffer to UIImage conversion
    
    func ciImageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        return CIImage(cvPixelBuffer: imageBuffer)
    }
    
    func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let ciImage = self.ciImageFromSampleBuffer(sampleBuffer: sampleBuffer) else {
            return nil
        }
        return self.uiImageFrom(ciImage: ciImage)
    }
    
    func uiImageFrom(ciImage: CIImage) -> UIImage? {
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    
}

// MARK: AVCaptureVideoDataOutputSampleBufferDelegate

extension EvrythngCameraFrameExtractor: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
        //guard let uiImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
        guard let ciImage = ciImageFromSampleBuffer(sampleBuffer: sampleBuffer) else {
            return
        }
        guard let uiImage = uiImageFrom(ciImage: ciImage) else {
            return
        }
        
        DispatchQueue.main.async { [unowned self] in
            //print("Is Running: \(self.captureSession.isRunning)")
            if(self.captureSession.isRunning) {
                self.delegate?.captured(uiImage: uiImage, ciImage: ciImage)
            }
        }
    }
}

// MARK: AVCaptureMetadataOutputObjectsDelegate

extension EvrythngCameraFrameExtractor: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
     
        var detectionString : String!
        let barCodeTypes = [AVMetadataObjectTypeUPCECode,
                            AVMetadataObjectTypeCode39Code,
                            AVMetadataObjectTypeCode39Mod43Code,
                            AVMetadataObjectTypeEAN13Code,
                            AVMetadataObjectTypeEAN8Code,
                            AVMetadataObjectTypeCode93Code,
                            AVMetadataObjectTypeCode128Code,
                            AVMetadataObjectTypePDF417Code,
                            AVMetadataObjectTypeAztecCode
        ]
        
        
        // The scanner is capable of capturing multiple 2-dimensional barcodes in one scan.
        for metadata in metadataObjects {
            
            for barcodeType in barCodeTypes {
                
                if (metadata as AnyObject).type == barcodeType {
                    detectionString = (metadata as! AVMetadataMachineReadableCodeObject).stringValue
                    //self.captureSession.stopRunning()
                    DispatchQueue.main.async { 
                        self.delegate?.captured2(value: detectionString)
                    }
                    break
                }
                
            }
        }
        print(detectionString)
    }
}
