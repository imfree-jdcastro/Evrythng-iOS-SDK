//
//  EvrythngScanner.swift
//  Evrythng-iOS
//
//  Created by JD Castro on 26/04/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//
//  Wrapper class to encapsulate barcode scanner module
//

import UIKit

public class EvrythngScanner {

    var delegate: EvrythngScannerResultDelegate?
    
    var barcodeScannerVC: EvrythngScannerVC
    var presentingVC: UIViewController?
    
    required public init(presentingVC: UIViewController?) {
        self.presentingVC = presentingVC
        self.barcodeScannerVC = EvrythngScannerVC()
        self.barcodeScannerVC.evrythngScannerDelegate = self
    }
    
    convenience init(presentingVC: UIViewController?, delegate: EvrythngScannerResultDelegate?) {
        self.init(presentingVC: presentingVC)
        self.presentingVC = presentingVC
        self.delegate = delegate
    }
    
    public final func queryScanResult(barcode: String) -> (result: String, error: Error?) {
        return ("QUERY_SCAN_RESULT_SUCCESS: \(barcode)", nil)
    }
    
    public final func scanBarcode() {
        self.presentingVC?.present(self.barcodeScannerVC, animated: true, completion: nil)
    }
    
    /*
    public func startScan() throws {
        
        let startScanCompletion: () -> Void = {
            self.delegate?.didStartScan()
            // TODO: Signal Evrythng API that it will start scanning
        }
        
        if let barcodeScannerVC = self.barcodeScannerVC {
            if(barcodeScannerVC is EvrythngScannerDelegate) {
                // NOTE: barcodeScannerVC should explicitly call didStartScan() to notify API
                self.presentingVC?.present(barcodeScannerVC, animated: true, completion: nil)
            } else {
                throw EvrythngScannerError.NotConformingToEvrthngScannerProtocol
            }
        
        } else {
            let defaultScannerVC = UIViewController()
            self.presentingVC?.present(defaultScannerVC, animated: true, completion: startScanCompletion)
        }
    }
     */
}

extension EvrythngScanner: EvrythngScannerDelegate {
    public func didStartScan() {
        
    }
    
    public func didFinishScan(value: String?, error: Error?) {
        guard let err = error else {
            guard let val = value else {
                print("Barcode Value is NULL")
                return
            }
            print("Default Scan Result: \(self.queryScanResult(barcode: val))")
            return
        }
        print(err.localizedDescription)
    }
}

extension EvrythngScanner: EvrythngScannerResultDelegate {
    public func didFinishScanResult(result: String, error: Error?) {
        
    }
}
