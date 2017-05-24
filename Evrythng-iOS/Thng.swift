//
//  Thng.swift
//  Evrythng-iOS
//
//  Created by JD Castro on 26/04/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit
import Moya_SwiftyJSONMapper
import SwiftyJSON

open class Thng: DurableResourceModel, ALSwiftyJSONAble {
    
    var name: String?
    var description: String?
    var batch: String?
    var product: String? //Reference to Product.id
    var createdByTask: String?
    var identifiers: Dictionary<String, String>?
    var collections: Array<String>?
    var properties: Dictionary<String, AnyObject>?
    
    required public init?(jsonData:JSON){
        super.init(jsonData: jsonData)
        self.name = jsonData["name"].string
        self.description = jsonData["description"].string
        self.batch = jsonData["batch"].string
        self.product = jsonData["product"].string
        self.createdByTask = jsonData["createdByTask"].string
        
        self.identifiers = jsonData["identifiers"].dictionaryObject as? Dictionary<String, String>
        self.collections = jsonData["collections"].arrayObject as? [String]
        self.properties = jsonData["properties"].dictionaryObject as Dictionary<String, AnyObject>?
    }
}
