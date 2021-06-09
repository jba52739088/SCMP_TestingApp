//
//  APIManager+Login.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import Foundation

extension APIManager {
    
    func login(account: String, password: String, complete: @escaping (Bool, Data?, HTTPURLResponse?, NSError?) -> (), failure: @escaping (Data?, HTTPURLResponse?, NSError?) -> ()) {
        
        let params = ["email": account,
                      "password": password]
        
        self.requestData(url: APIInfo.login, params: params, method: .POST, complete: complete, failure: failure)
    }
}
