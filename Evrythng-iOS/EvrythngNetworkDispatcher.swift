//
//  EvrythngNetworkDispatcher.swift
//  EvrythngiOS
//
//  Created by JD Castro on 09/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit
import Moya
import MoyaSugar

public class EvrythngNetworkDispatcher {
    
    public class func getUser(completionHandler: @escaping (AbstractUser?, Swift.Error?) -> Void)  {
        
        let userRepo = EvrythngNetworkService.userRepos(owner: "3c4b81f4-34ac-11e7-ae4c-b923aa7f9a8c")
        let provider = MoyaProvider<EvrythngNetworkService>()
        
        provider.request(userRepo) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let statusCode = moyaResponse.statusCode
                
                let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print("Data: \(datastring) Status Code: \(statusCode)")
                
                do {
                    let abstractUser = try moyaResponse.map(to: AbstractUser.self)
                    print("SwiftyJSON: \(abstractUser.json)")
                    completionHandler(abstractUser, nil)
                } catch {
                    print(error)
                    completionHandler(nil, error)      
                }
            // do something with the response data or statusCode
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
