//
//  StringUtils.swift
//  EvrythngiOS
//
//  Created by JD Castro on 26/04/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit

public class StringUtils {
    
    static func isStringEmpty(string: String?) -> Bool {
        if let string = string, !string.isEmpty {
            return false
        }
        return true
    }

}
