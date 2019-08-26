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
    var movieId: Int
    var movieDetails: MovieDetails?
    
    init(forMovieId movie: Int) {
        self.movieId = movie
    }
    
    func movieDetails(completion: @escaping (Bool) -> Void)  {
        movieAPI.movieDetails(forMovie: movieId) { (response) in
            switch response{
            case .success(let response):
                guard let movieDetails = response else { return }
                self.movieDetails = movieDetails
                completion(true)
            case .failure(let error):
                guard let error = error else { return }
                print(error.localizedDescription)
                 completion(false)
            }
        }
    }
    
}
