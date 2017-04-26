//
//  EvrythngScannerProtocol.swift
//  Evrythng-iOS
//
//  Created by JD Castro on 26/04/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit

public protocol EvrythngScannerDelegate: class {
    func didFinishScan(value: String?, withError: Bool?) -> Void
    func didStartScan() -> Void
    func didFailScan() -> Void
}
