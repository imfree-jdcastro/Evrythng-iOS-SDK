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
import SwiftyJSON

public class EvrythngNetworkDispatcher {
    
    /*
    public class func getUser(completionHandler: @escaping (AbstractUser?, Swift.Error?) -> Void)  {
        
        let userRepo = EvrythngNetworkService.userRepos(owner: "3c4b81f4-34ac-11e7-ae4c-b923aa7f9a8c")
        let provider = MoyaSugarProvider<EvrythngNetworkService>()
        
        provider.request(userRepo) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                
                if let datastring = String(data: data, encoding: .utf8) {
                    print("\(#function) Raw Response: \n\(datastring)")
                    
                    if let abstractUser = AbstractUser(JSONString: datastring), let jsonStr = abstractUser.toJSONString() {
                        
                        print("Serialized:\(jsonStr)")
                        completionHandler(abstractUser, nil)
                        
                    } else {
                        print("Unable to parse AbstractUser string: \(datastring)")
                        completionHandler(nil, EvrythngNetworkServiceError.dataParseException(source: datastring))
                    }
                } else {
                    print("Unable to parse response: \(#function)")
                    completionHandler(nil, EvrythngNetworkServiceError.responseParseException)
                }
                //let abstractUser = try moyaResponse.map(to: AbstractUser.self)
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
 */

}
