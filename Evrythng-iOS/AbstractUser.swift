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
    
    public class func toString() -> NSString? {
        let data = try! JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return string
    }
    
    public class var json: JSON {
        get {
            var dict = [String: AnyObject]()
            let mirror = Mirror(reflecting: self)
            for (_, attr) in mirror.children.enumerated() {
                if let property_name = attr.label as String! {
                    dict[property_name] = attr.value as? AnyObject
                }
            }
            return JSON(dict)
        }
    }
    
    public var gender: Gender? = .Female
    public var birthday: Date? = nil
    public var canLogin: Bool? = false
    public var project: String? = ""
    public var app: String? = ""
    public var numberOfFriends = 0
}
