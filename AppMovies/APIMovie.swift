//
//  APIMovie.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 22/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
protocol APIMovieProtocol: AnyObject {
    func popularMovies(forPage page: String , forLanguage language: String, completion: @escaping APIRequest.ResponseBlock<MoviesResponse>)
    func movieDetails(forMovie id: Int, completion: @escaping APIRequest.ResponseBlock<MovieDetails>)
}

class APIMovieDefault: APIMovieProtocol {
    
    func popularMovies(forPage page: String, forLanguage language: String, completion: @escaping APIRequest.ResponseBlock<MoviesResponse>) {
        let parameters = [ "language": language,
                           "page": page
                         ]
        let request = APIRequest(method: .get, path: "/movie/popular", parametersURL: parameters)
        request.makeRequest { (data, response, error) in
            print(response as Any)
            
            guard let httpResponse = (response as? HTTPURLResponse), let data = data, error == nil else {
                completion(.failure(API.standardError))
                return
            }
            
            if httpResponse.statusCode == 200{
//                do {
//                    let x = try JSONDecoder().decode(MoviesResponse.self, from: data)
//                    print("i eat it \(String(describing: x))")
//                } catch let error {
//                    print(error.localizedDescription)
//                }
                guard let result = try? JSONDecoder().decode(MoviesResponse.self, from: data) else {
                    completion(.failure(API.standardError))
                    return
                }
                completion(.success(result))
            } else  {
                guard let dataParameters = try? JSONSerialization.jsonObject(with: data, options: []), let parameters = dataParameters as? [String: Any], let message = parameters["errors"] as? [String] else {
                    completion(.failure(API.standardError))
                    return
                }
                let error: NSError = NSError(domain: "MovieAppError", code: httpResponse.statusCode, userInfo: ["Error":message[0]])
                completion(.failure(error))
            }
        }
    }
    
    
    func movieDetails(forMovie id: Int, completion: @escaping APIRequest.ResponseBlock<MovieDetails>) {
        let request = APIRequest(method: .get, path: "/movie/\(String(id))")
        request.makeRequest { (data, response, error) in
            print(response as Any)
            
            guard let httpResponse = (response as? HTTPURLResponse), let data = data, error == nil else {
                completion(.failure(API.standardError))
                return
            }
            if httpResponse.statusCode == 200{
                guard let result = try? JSONDecoder().decode(MovieDetails.self, from: data) else {
                    completion(.failure(API.standardError))
                    return
                }
                completion(.success(result))
            }else{
                guard let dataParameters = try? JSONSerialization.jsonObject(with: data, options: []), let parameters = dataParameters as? [String: Any], let message = parameters["errors"] as? [String] else {
                    completion(.failure(API.standardError))
                    return
                }
                let error: NSError = NSError(domain: "MovieAppError", code: httpResponse.statusCode, userInfo: ["Error":message[0]])
                completion(.failure(error))
            }
        }
    }
    
    
    
}
