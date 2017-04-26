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

    var delegate: EvrythngScannerDelegate?
    var barcodeScannerVC: UIViewController?
    var presentingVC: UIViewController?
    
    required public init(presentingVC: UIViewController?) {
        self.presentingVC = presentingVC
    }
    
    convenience init(presentingVC: UIViewController?, barcodeScannerVC: UIViewController?, delegate: EvrythngScannerDelegate?) {
        self.init(presentingVC: presentingVC)
        self.barcodeScannerVC = barcodeScannerVC
        self.presentingVC = presentingVC
        self.delegate = delegate
    }
    
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
}
