//
//  LoginRepository.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import Foundation

protocol LoginRepositoryInterface {
    func login(account: String, password: String, completion: @escaping (Result<LoginToken>) -> ())
    var loginToken: LoginToken? { get }
}

class LoginRepository {
    static let shared = LoginRepository()
    
    let apiManager: APIManager
    var loginToken: LoginToken?
    
    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
}

extension LoginRepository: LoginRepositoryInterface {
    
    func login(account: String, password: String, completion: @escaping (Result<LoginToken>) -> ()) {
        self.apiManager.login(account: account, password: password) { (status, data, response, error) in
            let decoder = JSONDecoder()
            if let jsonData = data,
               let token = try? decoder.decode(LoginToken.self, from: jsonData) {
                if status {
                    self.loginToken = token
                    completion(Result.success(token))
                }else {
                    completion(Result.failure(token.error))
                }
            }else {
                completion(Result.failure("api error"))
            }
        } failure: { (data, response, error) in
            completion(Result.failure(error.debugDescription))
        }

    }
}
