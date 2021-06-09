//
//  ResultVM.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import Foundation

protocol ResultVMInterface {
    var apiFaildSubject: Subject<String> {get}
    func getLoginToken(completion: @escaping (String) -> ())
}
    
class ResultVM {
    
    let apiFaildSubject = Subject<String>()
    var loginRepository: LoginRepositoryInterface
    
    init(loginRepository: LoginRepositoryInterface = LoginRepository.shared) {
        self.loginRepository = loginRepository
    }
    
}

extension ResultVM: ResultVMInterface {
    
    func getLoginToken(completion: @escaping (String) -> ()){
        completion(self.loginRepository.loginToken?.token ?? "get token error")
    }   
}
