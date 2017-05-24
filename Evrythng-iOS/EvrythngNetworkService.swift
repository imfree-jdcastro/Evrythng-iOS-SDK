//
//  EvrythngNetworkService.swift
//  EvrythngiOS
//
//  Created by JD Castro on 26/04/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import Foundation

import Moya
import MoyaSugar

public enum EvrythngNetworkService {
    case url(String)
    case userRepos(owner: String)
    
    case createUser(user: User?)
    case deleteUser(operatorApiKey: String, userId: String)
    
    case createIssue(owner: String, repo: String, title: String, body: String?)
    case editIssue(owner: String, repo: String, number: Int, title: String?, body: String?)
    
    case readThng(thngId: String, userId: String)
}

extension EvrythngNetworkService: SugarTargetType {
    
    public var baseURL: URL { return URL(string: "https://api.evrythng.com")! }
    //public var baseURL: URL { return URL(string: "https://www.jsonblob.com/api")! }
    
    /// method + path
    public var route: Route {
        switch self {
        case .url(let urlString):
            return .get(urlString)
            
        case .userRepos(let owner):
            return .get("/\(owner)")
            
        case .createIssue(let owner, let repo, _, _):
            return .post("/repos/\(owner)/\(repo)/issues")
            
        case .createUser(let user):
            var folder = "/auth/evrythng/users"
            if(user == nil) {
                folder = self.setQueryParams(pathSrc: folder, dict: ["anonymous":"true"])
            }
            return .post(folder)
            
        case .deleteUser(_, let userId):
            return .delete("/users/\(userId)")
            
        case .editIssue(let owner, let repo, let number, _, _):
            return .patch("/repos/\(owner)/\(repo)/issues/\(number)")
            
        case .readThng(let thngId, let userId):
            //return .get("/thngs/\(thngId)?project=UGbCDnpTBDPw9KawwYfthAaa&userScope=\(userId)")
            return .get("/thngs/\(thngId)")
        }
    }
    
    // override default url building behavior
    public var url: URL {
        switch self {
        case .url(let urlString):
            return URL(string: urlString)!
        default:
            return self.defaultURL
        }
    }
    
    /// encoding + parameters
    public var params: Parameters? {
        switch self {
        case .url:
            return nil
            
        case .userRepos:
            return nil
            
        case .createIssue(_, _, let title, let body):
            return JSONEncoding() => [
                "title": title,
                "body": body,
            ]
            
        case .createUser(let user):
            return JSONEncoding() => user!.jsonData!.dictionaryObject!
            /*
            [
                "firstName": "Test First1", "lastName": "Test Last1", "email": "validemail1@email.com", "password": "testPassword1"
            ]
            */
        case .deleteUser:
            return nil
            
        case .editIssue(_, _, _, let title, let body):
            // Use `URLEncoding()` as default when not specified
            return [
                "title": title,
                "body": body,
            ]
            
        case .readThng:
            return nil
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .url:
            return "{}".utf8Encoded
        case .createIssue(let owner, _, let title, _):
            return "{\"id\": 100, \"owner\": \"\(owner)}".utf8Encoded
        case .editIssue(_, let owner, _, let title, _):
            return "{\"id\": 100, \"owner\": \"\(owner)}".utf8Encoded
        case .createUser(_):
            return "{}".utf8Encoded
        case .deleteUser:
            return "{}".utf8Encoded
        case .userRepos(let ownerId):
            return "{\"ownerId\": \"\(ownerId)}".utf8Encoded
            // Provided you have a file named accounts.json in your bundle.
            /*
             guard let path = Bundle.main.path(forResource: "accounts", ofType: "json"),
             let data = Data(base64Encoded: path) else {
             return Data()
             }
             return data
             */
        case .readThng:
            return "{}".utf8Encoded
        }
    }
    
    public var httpHeaderFields: [String: String]? {
        var headers: [String:String] = [:]
        
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        
        var authorization: String?
        switch(self) {
        case .deleteUser(let operatorApiKey, _):
            // Operator API Key
            //authorization = "hohzaKH7VbVp659Pnr5m3xg2DpKBivg9rFh6PttT5AnBtEn3s17B8OPAOpBjNTWdoRlosLTxJmUrpjTi"
            authorization = operatorApiKey
        default:
            authorization = UserDefaultsUtils.get(key: "pref_key_authorization") as? String
            if let authorization = UserDefaultsUtils.get(key: "pref_key_authorization") as? String{
                headers["Authorization"] = authorization
            }
        }
        
        if let auth = authorization {
            if(!auth.isEmpty) {
                headers["Authorization"] = auth
            }
        }
        
        print("Headers: \(headers)")
        return headers
    }
    
    public var task: Task {
        switch self {
        case .userRepos, .createIssue, .editIssue, .createUser, .url:
            fallthrough
        default:
            return .request
        }
    }
}

extension EvrythngNetworkService {
    
    func setQueryParams(pathSrc: String, dict: Dictionary<String, String>) -> String {
        
        var pathWithQueryParams = pathSrc
        
        var i=0
        for item in dict {
            let key = item.key, val = item.value
            
            if(i>0) {
                pathWithQueryParams += "&"
            } else {
                pathWithQueryParams += "?"
            }
            
            pathWithQueryParams += "\(key)=\(val)"
            
            i+=1
        }
        
        return pathWithQueryParams
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
