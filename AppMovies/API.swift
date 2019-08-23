//
//  API.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 22/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation

struct API {
    static let standardError = NSError(domain: "MovieAppError", code: 999, userInfo: ["Error":"Não foi possível conectar. Verifique se o app está atualizado ou tente novamente em alguns minutos."])
    
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
    private let scheme = "https"
    private let host = "api.themoviedb.org"
    private let versionAPI = "/3"
    private var path: String
    private var queryItem = URLQueryItem(name: "api_key", value: "564c8466dee585ae1bd14b65b40c524")
    private let httpMethod: API.HTTPMethod
    private var extraHeader: [String: String]?
    private var parametersBody: [String: String]?
    private var parametersURL: [String: String]?
    
    init(method: API.HTTPMethod, path: String, parametersBody:[String:String]? = nil, parametersURL:[String:String]? = nil, headers:[String: String]? = nil ) {
        self.httpMethod = method
        self.path = path
        self.extraHeader = headers
        self.parametersBody = parametersBody
        self.parametersURL = parametersURL
    }
    
    func makeRequest(completion: @escaping (Data?, URLResponse?, Error?) -> Void)  {
    
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = versionAPI
        urlComponents.path.append(path)
        urlComponents.queryItems = [queryItem]
        
        if let parameters = parametersURL{
            for item in parameters{
                urlComponents.queryItems?.append(URLQueryItem(name: item.key, value: item.value))
            }
        }
        
        guard let urlRequest = urlComponents.url else { return }
        var request = URLRequest(url: urlRequest)
        request.httpMethod = httpMethod.rawValue
        
        
        
        if let httpBody = parametersBody {
            request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody)
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
