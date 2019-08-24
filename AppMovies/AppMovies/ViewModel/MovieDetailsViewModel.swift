//
//  MovieDetailsViewModel.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
class MovieDetailsViewModel {
    fileprivate(set) var movieAPI: APIMovieProtocol = APIMovieDefault()
    
    var movie: Movie
    
    init(forMovie movie: Movie) {
        self.movie = movie
    }
    
    func movieDetails(completion: @escaping (Bool) -> Void)  {
        movieAPI.movieDetails(forMovie: movie.id) { (response) in
            switch response{
            case .success(let response):
                completion(true)
            case .failure(let error):
                 completion(false)
            }
        }
    }
    
}
