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
    var movieDetails: MovieDetails?
    
    init(forMovie movie: Movie) {
        self.movie = movie
    }
    
    func movieDetails(completion: @escaping (Bool) -> Void)  {
        movieAPI.movieDetails(forMovie: movie.id) { (response) in
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
