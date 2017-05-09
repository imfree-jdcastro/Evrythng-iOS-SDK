//
//  EvrythngScannerResultDelegate.swift
//  EvrythngiOS
//
//  Created by JD Castro on 09/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit

public protocol EvrythngScannerResultDelegate: class {
    func didFinishScanResult(result: String, error: Error?) -> Void
}

extension EvrythngScannerResultDelegate {
    
}
