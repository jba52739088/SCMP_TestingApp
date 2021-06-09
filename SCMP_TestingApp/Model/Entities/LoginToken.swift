//
//  LoginToken.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import Foundation

struct LoginToken: Codable {
    
    let token: String
    let error: String
    
    enum Keys: String, CodingKey {
        case token
        case error
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
        error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
    }
}
