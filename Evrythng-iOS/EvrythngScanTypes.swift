//
//  EvrythngScanTypes.swift
//  EvrythngiOS
//
//  Created by JD Castro on 29/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit

public enum EvrythngScanTypes: String {
    
    // OCR
    case TEXT = "text"
    
    // IR
    case IMAGE = "image"
    
    // 1D
    case CODABAR = "codabar"
    case CODE_11 = "code_11"
    case CODE_39 = "code_39"
    case CODE_93 = "code_93"
    case CODE_128 = "code_128"
    case EAN_8 = "ean_8"
    case EAN_13 = "ean_13"
    case CODE_25_INDUSTRIAL = "industr_25"
    case ITF_14 = "itf"
    case GS_1_DATABAR = "rss_14"
    case DATA_BAR_RSS_EXPANDED = "rss_expanded"
    case DATA_BAR_LIMITED = "rss_limited"
    case UPC_A = "upc_a"
    case UPC_E = "upc_e"
    
    // 2D
    case QR_CODE = "qr_code"
    

}
