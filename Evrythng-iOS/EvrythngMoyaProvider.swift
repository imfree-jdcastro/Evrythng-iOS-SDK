//
//  EvrythngMoyaProvider.swift
//  EvrythngiOS
//
//  Created by JD Castro on 15/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit

import MoyaSugar
import Moya
import Moya_SwiftyJSONMapper

public class EvrythngMoyaProvider<Target>: MoyaSugarProvider<Target> where Target: SugarTargetType {
    
    public init() {
        super.init()
    }
    
    public override init(endpointClosure: @escaping (Target) -> Endpoint<Target>, requestClosure: @escaping (Endpoint<Target>, @escaping MoyaSugarProvider<Target>.RequestResultClosure) -> Void, stubClosure: @escaping (Target) -> StubBehavior, manager: Manager, plugins: [PluginType], trackInflights: Bool) {
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: DefaultAlamofireManager.sharedManager, plugins: plugins)
    }
    
}
