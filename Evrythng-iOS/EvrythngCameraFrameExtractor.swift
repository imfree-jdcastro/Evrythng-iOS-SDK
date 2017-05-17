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
    func captured(uiImage image: UIImage)
    func captured(ciImage image: CIImage)
}

internal class EvrythngCameraFrameExtractor: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let position = AVCaptureDevicePosition.back
    private let quality = AVCaptureSessionPresetMedium
    
    private var permissionGranted = false
    private let sessionQueue = DispatchQueue(label: "session queue")
    private let captureSession = AVCaptureSession()
    private let context = CIContext()
    
    weak var delegate: EvrythngCameraFrameExtractorDelegate?
    
    override init() {
        super.init()
        checkPermission()
        sessionQueue.async { [unowned self] in
            self.configureSession()
            self.captureSession.startRunning()
        }
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
    
    // MARK: Private Class Functions
    
    private func requestPermission() {
        sessionQueue.suspend()
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
        guard permissionGranted else { return }
        captureSession.sessionPreset = quality
        guard let captureDevice = selectCaptureDevice() else { return }
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        guard captureSession.canAddInput(captureDeviceInput) else { return }
        captureSession.addInput(captureDeviceInput)
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer"))
        guard captureSession.canAddOutput(videoOutput) else { return }
        captureSession.addOutput(videoOutput)
        guard let connection = videoOutput.connection(withMediaType: AVFoundation.AVMediaTypeVideo) else { return }
        guard connection.isVideoOrientationSupported else { return }
        guard connection.isVideoMirroringSupported else { return }
        connection.videoOrientation = .portrait
        connection.isVideoMirrored = position == .front
        print("Configure Session Successful")
    }
    
    private func selectCaptureDevice() -> AVCaptureDevice? {
        if #available(iOS 10.2, *) {
            return AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaTypeVideo, position: position).devices.first
        } else {
            // Fallback on earlier versions
            return AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: position).devices.first
        }
        /*
        return AVCaptureDevice.devices().filter {
            ($0 as AnyObject).hasMediaType(AVMediaTypeVideo) &&
                ($0 as AnyObject).position == position
            }.first as? AVCaptureDevice
         */
    }
    
    // MARK: Sample buffer to UIImage conversion
    
    private func ciImageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        return CIImage(cvPixelBuffer: imageBuffer)
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let ciImage = self.ciImageFromSampleBuffer(sampleBuffer: sampleBuffer) else {
            return nil
        }
        return self.uiImageFrom(ciImage: ciImage)
    }
    
    private func uiImageFrom(ciImage: CIImage) -> UIImage? {
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    // MARK: AVCaptureVideoDataOutputSampleBufferDelegate
    
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
                self.delegate?.captured(uiImage: uiImage)
                self.delegate?.captured(ciImage: ciImage)
            }
        }
    }
}
