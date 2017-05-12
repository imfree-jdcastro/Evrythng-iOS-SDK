
//
//  EvrythngUserCreator.swift
//  EvrythngiOS
//
//  Created by JD Castro on 12/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit
import Moya
import MoyaSugar
import Moya_SwiftyJSONMapper

public class EvrythngUserCreator {
    
    var user: User?
    
    public init(user: User?) {
        self.user = user
    }
    
    public func execute(completionHandler: @escaping (User?, Swift.Error?) -> Void) {
        
        let userRepo = EvrythngNetworkService.createUser(user: self.user)
        let provider = MoyaSugarProvider<EvrythngNetworkService>()
        
        provider.request(userRepo) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let statusCode = moyaResponse.statusCode
                
                let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print("Data: \(datastring) Status Code: \(statusCode)")
                
                do {
                    let user = try moyaResponse.map(to: User.self)
                    print("SwiftyJSON: \(user)")
                    completionHandler(user, nil)
                } catch {
                    print(error)
                    completionHandler(nil, error)
                }
            case let .failure(error):
                print("Error: \(error)")
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
                completionHandler(nil, error)
                break
            }
        }
    }
}
