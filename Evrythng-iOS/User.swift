//
//  User.swift
//  Evrythng-iOS
//
//  Created by JD Castro on 26/04/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

public final class User: AbstractUser {
    
    public typealias UserBuilder = (User) -> Void
    
    public var email: String?
    public var password: String?
    public var firstName: String?
    public var lastName: String?
    public private(set) var activationCode: String?
    public private(set) var status: String?
    
    required public init?(jsonData: JSON) {
        super.init(jsonData: jsonData)
        
        self.email = jsonData["email"].stringValue
        self.password = jsonData["password"].stringValue
        self.firstName = jsonData["firstName"].stringValue
        self.lastName = jsonData["lastName"].stringValue
        self.activationCode = jsonData["activationCode"].stringValue
        self.status = jsonData["status"].stringValue
    }
    
    public init(userBuilder: UserBuilder) {
        super.init()
        userBuilder(self)
    }
}
