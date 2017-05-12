//
//  EvrythngNetworkExecutableProtocol.swift
//  EvrythngiOS
//
//  Created by JD Castro on 12/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit
import Moya_SwiftyJSONMapper

public protocol EvrythngNetworkExecutableProtocol {
    //func execute<T>(completionHandler: @escaping (T?,Swift.Error?) -> Void) where T: ALSwiftyJSONAble
    func execute<T>(completionHandler: @escaping (T?,Swift.Error?) -> Void) where T: ALSwiftyJSONAble
}
