//
//  MovieViewModel.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
class MovieViewModel {
    
    fileprivate(set) var movieAPI: APIMovieProtocol = APIMovieDefault()
    fileprivate(set) var movies: [Movie] = []
    var pagination: Pagination
    
    init(defaultPagination: Pagination) {
        self.pagination = defaultPagination
    }
    
    func popularMovies(completion: @escaping (Bool) -> Void)  {
        movieAPI.popularMovies(forPage: String(pagination.page), forLanguage: "en-US") { (response) in
            switch response{
            case .success(let response):
                guard let response = response else { return }
                self.pagination = Pagination(page: response.page, totalResults: response.totalResults, totalPage: response.totalPage)
                self.movies = response.movies
                completion(true)
            case .failure(let error):
                guard let error = error else{
                    return
                }
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
}