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

open class Thng: DurableResourceModel {
    
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
        self.name = jsonData["name"].stringValue
        self.description = jsonData["description"].stringValue
        self.batch = jsonData["batch"].stringValue
        self.product = jsonData["product"].stringValue
        self.createdByTask = jsonData["createdByTask"].stringValue
        
        self.identifiers = jsonData["identifiers"].dictionaryObject as? Dictionary<String, String>
        self.collections = jsonData["collections"].arrayObject as? [String]
        self.properties = jsonData["properties"].dictionaryObject as Dictionary<String, AnyObject>?
    }
}
