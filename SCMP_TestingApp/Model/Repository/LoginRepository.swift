//
//  LoginRepository.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import Foundation

protocol LoginRepositoryInterface {
    func login(account: String, password: String, completion: @escaping (Result<LoginToken>) -> ())
}

class LoginRepository {
    static let shared = LoginRepository()
    
    let apiManager: APIManager
    
    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
}

extension LoginRepository: LoginRepositoryInterface {
    
    func login(account: String, password: String, completion: @escaping (Result<LoginToken>) -> ()) {
        self.apiManager.login(account: account, password: password) { (status, data, response, error) in
            if status {
                let decoder = JSONDecoder()
                if let jsonData = data {
                    if let result = try? decoder.decode(LoginToken.self, from: jsonData) {
                        completion(Result.success(result))
                    }
                }
            }else {
                
            }
        } failure: { (data, response, error) in
            //
        }

    }
}
