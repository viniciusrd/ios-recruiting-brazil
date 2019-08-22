//
//  API.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 22/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation

struct API {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    enum Response<T> {
        case success(T?)
        case failure(Error?)
    }
}



class APIRequest {
    
    typealias ResponseBlock<T> = (_ reponse: API.Response<T>) -> Void
    
    private let standardError = NSError(domain: "MovieAppError", code: 999, userInfo: ["Error":"Não foi possível conectar. Verifique se o app está atualizado ou tente novamente em alguns minutos."])
    
    private let baseURL = "https://api.themoviedb.org/3/"
    private var path: String
    private let httpMethod: API.HTTPMethod
    private var extraHeader: [String: String]?
    private var parameters: [String: Any]?
    
    init(_ method: API.HTTPMethod, path: String, parameters:[String:Any]? = nil, headers:[String: String]? = nil ) {
        self.httpMethod = method
        self.path = path
        self.extraHeader = headers
        self.parameters = parameters
    }
    
    func makeRequest(completion: @escaping (Data?, URLResponse?, Error?) -> Void)  {
    
        let urlRequest = URL(fileURLWithPath: baseURL + path)
        var request = URLRequest(url: urlRequest)
        request.httpMethod = httpMethod.rawValue
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        if let extraHeader = extraHeader{
            request.allHTTPHeaderFields = extraHeader
        }
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        print(request as Any)
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
            print(response as Any)
            }.resume()
    }
}
