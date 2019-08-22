//
//  APIMovie.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 22/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
protocol APIMovieProtocol: AnyObject {
    @discardableResult
    func movies(forPage page: Int , forLanguage language: String, completion: @escaping APIRequest.ResponseBlock<[String]>)
}

class APIMovieDefault: APIMovieProtocol {
    
    func movies(forPage page: Int, forLanguage language: String, completion: @escaping APIRequest.ResponseBlock<[String]>) {
        
    }
    
    
}
