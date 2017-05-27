//
//  AuthService.swift
//  EvrythngiOS
//
//  Created by JD Castro on 16/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit

public class AuthService {
    public func evrythngUserCreator(user: User?) -> EvrythngUserCreator {
        return EvrythngUserCreator(user: user)
    }
    
    public func evrythngOperator(operatorApiKey: String) -> EvrythngOperator {
        return EvrythngOperator(operatorApiKey: operatorApiKey)
    }
}
