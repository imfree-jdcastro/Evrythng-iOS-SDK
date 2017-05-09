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
    case createIssue(owner: String, repo: String, title: String, body: String?)
    case editIssue(owner: String, repo: String, number: Int, title: String?, body: String?)
}

extension EvrythngNetworkService : SugarTargetType {
    
    public var baseURL: URL { return URL(string: "https://jsonblob.com/api")! }
    
    /// method + path
    public var route: Route {
        switch self {
        case .url(let urlString):
            return .get(urlString)
            
        case .userRepos(let owner):
            return .get("/\(owner)")
            
        case .createIssue(let owner, let repo, _, _):
            return .post("/repos/\(owner)/\(repo)/issues")
            
        case .editIssue(let owner, let repo, let number, _, _):
            return .patch("/repos/\(owner)/\(repo)/issues/\(number)")
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
            
        case .editIssue(_, _, _, let title, let body):
            // Use `URLEncoding()` as default when not specified
            return [
                "title": title,
                "body": body,
            ]
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .url:
            return "abcd".utf8Encoded
        case .createIssue(let owner, _, let title, _):
            return "{\"id\": 100, \"owner\": \"\(owner)}".utf8Encoded
        case .editIssue(_, let owner, _, let title, _):
            return "{\"id\": 100, \"owner\": \"\(owner)}".utf8Encoded
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
        }
    }
    
    public var httpHeaderFields: [String: String]? {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    public var task: Task {
        switch self {
        case .userRepos, .createIssue, .editIssue, .url:
            fallthrough
        default:
            return .request
        }
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
 
