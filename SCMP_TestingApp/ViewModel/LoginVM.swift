//
//  LoginVM.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import Foundation

protocol LoginVMInterface {
    var apiFaildSubject: Subject<String> {get}
    func login(account: String, password: String, completion: @escaping (String) -> ())
}
    
class LoginVM {
    
    let apiFaildSubject = Subject<String>()
    var loginRepository: LoginRepositoryInterface
    
    init(loginRepository: LoginRepositoryInterface = LoginRepository.shared) {
        self.loginRepository = loginRepository
    }
    
}

extension LoginVM: LoginVMInterface {
    
    
    func login(account: String, password: String, completion: @escaping (String) -> ()) {
        DispatchQueue.global(qos: .background).async {
            self.loginRepository.login(account: account, password: password) { (result) in
                switch result {
                case .success(let token):
                    DispatchQueue.main.async {
                        completion(token.token)
                    }
                case .failure(let message):
                    self.apiFaildSubject.value = message
                }
            }
        }
    }
}
