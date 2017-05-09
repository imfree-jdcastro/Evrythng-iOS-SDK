//
//  EvrythngScannerVC.swift
//  EvrythngiOS
//
//  Created by JD Castro on 09/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit

class EvrythngScannerVC: UIViewController {
    
    // MARK: - Public Variables
    
    var evrythngScannerDelegate: EvrythngScannerDelegate?

    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Public Methods
    
    public func scan(barcode: String) {
        self.dismiss(animated: true) { 
            self.evrythngScannerDelegate?.didFinishScan(value: "DEFAULT_SCANNER_VALUE_ABCDE98765123", error: nil)
        }
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
