//
//  AbstractUser.swift
//  Evrythng-iOS
//
//  Created by JD Castro on 26/04/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit
import Moya_SwiftyJSONMapper
import SwiftyJSON

public class AbstractUser: UserDelegate, ALSwiftyJSONAble {

    required public init?(jsonData:JSON){
        self.gender = Gender(rawValue: jsonData["gender"].stringValue)
        self.birthday = jsonData["origin"].date
        self.canLogin = jsonData["canLogin"].boolValue
        self.project = jsonData["project"].stringValue
        self.app = jsonData["app"].stringValue
        self.numberOfFriends = jsonData["numberOfFriends"].intValue
    }
    
    public var gender: Gender? {
        get {
            return .Female
        } set {
            
        }
    }
    public var birthday: Date? {
        get {
            return Date()
        } set {
            
        }
    }
    public var canLogin: Bool? {
        get {
            return false
        } set {
            
        }
    }
    public var project: String? {
        get {
            return nil
        } set {
            
        }
    }
    public var app: String? {
        get {
            return nil
        } set {
            
        }
    }
    public var numberOfFriends: Int {
        get {
            return 0
        } set {
            
        }
    }
}
