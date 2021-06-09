//
//  APIManger.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import Foundation

enum HttpMethod: String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}


enum APPError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

enum Result<T> {
    case success(T)
    case failure(String)
}

class APIManager {
    var request : URLRequest?
    var session : URLSession?
    static let shared = APIManager()

    func requestData(url: String, params: Dictionary<String, Any>?, method: HttpMethod, complete: @escaping (Bool, Data?, HTTPURLResponse?, NSError?) -> (), failure: @escaping (Data?, HTTPURLResponse?, NSError?) -> ()) {
        
        self.request = URLRequest(url: URL(string: url)!)
        if let params = params {
            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request?.httpBody = jsonData
        }
        request?.httpMethod = method.rawValue
        
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        session = URLSession(configuration: configuration)
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    complete(true, data, response, error as NSError?)
                } else {
                    complete(false, data, response as? HTTPURLResponse, error as NSError?)
                }
            }else {
                failure(data , response as? HTTPURLResponse, error as NSError?)
            }
        }.resume()
    }
}
