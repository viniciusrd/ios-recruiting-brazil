//
//  MovieViewModel.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation

protocol MovieViewModelDelegate {
    func didChangedMovies()
    func startRequest()
    func endRequest()
}

class MovieViewModel {
    
    fileprivate(set) var movieAPI: APIMovieProtocol = APIMovieDefault()
    fileprivate(set) var movies: [Movie] = []
    var pagination: Pagination
    var delegate: MovieViewModelDelegate?
    
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
    
    func searchMovie(searchText: String) {
        let query =  QueryMovie(language: "en-US", page: 1, adult: false, query: searchText)
        self.delegate?.startRequest()
        movieAPI.searchMovie(forQuery: query) { (response) in
            self.delegate?.endRequest()
            switch response{
            case .success(let response):
                guard let response = response else { return }
                self.pagination = Pagination(page: response.page, totalResults: response.totalResults, totalPage: response.totalPage)
                self.movies = response.movies
                self.delegate?.didChangedMovies()
            case .failure(let error):
                guard let error = error else{
                    return
                }
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
}
