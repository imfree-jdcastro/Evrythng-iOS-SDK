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

public enum EvrythngScannerModes: Int {
    case BARCODE = 1
    case QRCODE
}

public enum EvrythngScannerModeStrategy {
    case HIERARCHICAL // Will use the strategy from 1 ..< EvrythngScannerModes.rawValue
    case STATIC // Will only use the selected EvrythngScannerMode itself
}

public class EvrythngScanner {

    weak var delegate: EvrythngScannerResultDelegate?
    
    var barcodeScannerVC: EvrythngScannerVC
    var presentingVC: UIViewController?
    
    var scannerMode: EvrythngScannerModes = .QRCODE
    var scannerModeStrategy: EvrythngScannerModeStrategy = .HIERARCHICAL
    
    required public init(presentedBy presentingVC: UIViewController?) {
        self.presentingVC = presentingVC
        self.barcodeScannerVC = EvrythngScannerVC(nibName: "EvrythngScannerVC", bundle: Bundle(identifier: "com.imfreemobile.EvrythngiOS"))
        self.barcodeScannerVC.evrythngScannerDelegate = self
    }
    
    convenience public init(presentedBy presentingVC: UIViewController?, withResultDelegate delegate: EvrythngScannerResultDelegate?) {
        self.init(presentedBy: presentingVC)
        self.presentingVC = presentingVC
        self.delegate = delegate
    }
    
    public final func identify(barcode: String, completionHandler: @escaping (_ result: String, _ error: Error?) -> Void) {
        completionHandler("QUERY_SCAN_RESULT_SUCCESS: \(barcode)", nil)
    }
    
    public final func identify(barcode: String) {
        self.delegate?.didFinishScanResult(result: "QUERY_SCAN_RESULT_SUCCESS: \(barcode)", error: nil)
    }
    
    public final func scanBarcode() {
        if let navPresentingVC = self.presentingVC?.navigationController {
            navPresentingVC.pushViewController(self.barcodeScannerVC, animated: true)
        } else {
             self.presentingVC?.present(self.barcodeScannerVC, animated: true, completion: nil)
        }
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
            self.identify(barcode: val, completionHandler: { (result, err) in
                self.delegate?.didFinishScanResult(result: result, error: err)
            })
            //print("Default Scan Result: \(self.identify(barcode: val))")
            return
        }
        print(err.localizedDescription)
    }
}
