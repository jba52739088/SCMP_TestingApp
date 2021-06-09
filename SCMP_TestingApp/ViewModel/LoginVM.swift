//
//  LoginVM.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import Foundation

protocol LoginVMInterface {
    func login(account: String, password: String, completion: @escaping (Result<LoginToken>) -> ())
}
    
class LoginVM {
    var loginRepository: LoginRepositoryInterface
    
    init(loginRepository: LoginRepositoryInterface = LoginRepository.shared) {
        self.loginRepository = loginRepository
    }
    
}

extension LoginVM: LoginVMInterface {
    func login(account: String, password: String, completion: @escaping (Result<LoginToken>) -> ()) {
        DispatchQueue.global(qos: .background).async {
            self.loginRepository.login(account: account, password: password) { (result) in
                //
            }
        }
    }
}
