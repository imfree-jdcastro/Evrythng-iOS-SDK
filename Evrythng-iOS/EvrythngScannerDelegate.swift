//
//  EvrythngScannerProtocol.swift
//  Evrythng-iOS
//
//  Created by JD Castro on 26/04/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit

public protocol EvrythngScannerDelegate: class {
    func didFinishScan(value: String?, error: Error?) -> Void
    func didStartScan() -> Void
}

extension EvrythngScannerDelegate {
    
}
