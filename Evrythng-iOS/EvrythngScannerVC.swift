//
//  EvrythngScannerVC.swift
//  EvrythngiOS
//
//  Created by JD Castro on 17/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit

internal class EvrythngScannerVC: UIViewController {

    // MARK: - Public Variables
    
    var evrythngScannerDelegate: EvrythngScannerDelegate?
    var cameraFrameExtractor: EvrythngCameraFrameExtractor!
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EvrythngScanner"
        //self.cameraFrameExtractor = EvrythngCameraFrameExtractor()
        //self.cameraFrameExtractor.delegate = self
        self.scanImage(ciImage: nil)
    }
    
    func scanImage(ciImage: CIImage?) {
        
        var ciimg:CIImage? = nil
        
        constructCIImage:
        if (ciImage != nil) {
            ciimg = ciImage
        } else { // Sample only
            let actualUrl = "http://cdnqrcgde.s3-eu-west-1.amazonaws.com/wp-content/uploads/2013/11/jpeg.jpg" //http://imgur.com/bcdARJf.jpg
            
            guard let url:NSURL = NSURL(string:actualUrl) else {
                ciimg = nil
                break constructCIImage
            }
            ciimg = CIImage(contentsOf:url as URL)
        }
        
        if let ciImageToProcess = ciimg {
            if let cid:CIDetector = CIDetector(ofType:CIDetectorTypeFace, context:nil, options:[CIDetectorAccuracy: CIDetectorAccuracyHigh]) {
                
                let results:NSArray = cid.features(in: ciImageToProcess) as NSArray
                printResults(withResults: results)
            }
            
            if let cid:CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]) {
                
                let results:NSArray = cid.features(in: ciImageToProcess) as NSArray
                printResults(withResults: results)
            }
        } else {
            print("CIImage is NIL")
        }
    }
    
    private func printResults(withResults results: NSArray) {
        for r in results {
            if let face = r as? CIFaceFeature {
                NSLog("Face found at (%f,%f) of dimensions %fx%f", face.bounds.origin.x, face.bounds.origin.y, face.bounds.width, face.bounds.height);
            }
            
            if let qr = r as? CIQRCodeFeature {
                print("QR Code Found: \(qr.messageString) at \(qr.bounds.origin.x)x\(qr.bounds.origin.y) with Size: \(qr.bounds.width)x\(qr.bounds.height)")
                //NSLog("QR Code found with value: at (%f,%f) of dimensions %fx%f With Value: %@", qr.bounds.origin.x, qr.bounds.origin.y, qr.bounds.width, qr.bounds.height, qr.messageString as Any);
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.cameraFrameExtractor.stopSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //            self.startScan()
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Public Methods
    
    public func startScan() {
//        self.dismiss(animated: true) {
//            self.evrythngScannerDelegate?.didFinishScan(value: "DEFAULT_SCANNER_VALUE_ABCDE98765123", error: nil)
//        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EvrythngScannerVC: EvrythngCameraFrameExtractorDelegate {
    func captured(uiImage: UIImage) {
        
        self.imageView.image = uiImage
        
        /*
        DispatchQueue.main.async {
            if let navPresentingVC = self.navigationController {
                navPresentingVC.popViewController(animated: true)
                self.evrythngScannerDelegate?.didFinishScan(value: "DEFAULT_SCANNER_VALUE_ABCDE98765123", error: nil)
            } else {
                self.dismiss(animated: true) {
                    self.evrythngScannerDelegate?.didFinishScan(value: "DEFAULT_SCANNER_VALUE_ABCDE98765123", error: nil)
                }
            }
        }
         */
    }
    
    func captured(ciImage: CIImage) {
        scanImage(ciImage: ciImage)
    }
}
