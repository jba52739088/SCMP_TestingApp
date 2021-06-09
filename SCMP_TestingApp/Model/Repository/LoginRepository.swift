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
            let decoder = JSONDecoder()
            if let jsonData = data,
               let result = try? decoder.decode(LoginToken.self, from: jsonData) {
                if status {
                    completion(Result.success(result))
                }else {
                    completion(Result.failure(result.error))
                }
            }else {
                completion(Result.failure("api error"))
            }
        } failure: { (data, response, error) in
            completion(Result.failure(error.debugDescription))
        }

    }
}
