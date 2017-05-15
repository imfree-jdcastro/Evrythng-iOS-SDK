//
//  EvrythngOperator.swift
//  EvrythngiOS
//
//  Created by JD Castro on 12/05/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit
import Moya
import MoyaSugar
import Moya_SwiftyJSONMapper

public class EvrythngOperator: EvrythngNetworkExecutableProtocol {
    
    private var userId: String?
    private var operatorApiKey: String
    
    public required init(operatorApiKey: String) {
        self.operatorApiKey = operatorApiKey
    }
    
    public func deleteUser(userId: String) -> EvrythngOperator {
        self.userId = userId
        return self
    }
    
    public func getDefaultProvider() -> EvrythngMoyaProvider<EvrythngNetworkService> {
        return EvrythngMoyaProvider<EvrythngNetworkService>()
    }
    
    public func execute(completionHandler: @escaping (User? , Swift.Error?) -> Void) {
        if let userId = self.userId {
            let userRepo = EvrythngNetworkService.deleteUser(userId: userId)
            //let provider = MoyaSugarProvider<EvrythngNetworkService>()
            
            self.getDefaultProvider().request(userRepo) { result in
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    let statusCode = moyaResponse.statusCode
                    
                    let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("Data: \(datastring) Status Code: \(statusCode)")
                    
                    if(moyaResponse.statusCode == 200) {
                        completionHandler(nil, nil)
                    } else {
                        completionHandler(nil, EvrythngNetworkServiceError.userDeletionFailedException)
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

}
