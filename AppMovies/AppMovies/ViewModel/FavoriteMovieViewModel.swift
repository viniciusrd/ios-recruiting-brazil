//
//  FavoriteMovieViewModel.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 26/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
import CoreData

protocol FavoriteMovieViewModelDelegate {
    func didChangedFavorites()
}

class FavoriteMovieViewModel {
    
    private(set) var favoriteMovieManager = FavoriteMovieManager.shared
    private(set) var favoriteMovie: FavoriteMovie?
    var movie: Movie?
    var favoritesMovies: [FavoriteMovie] = []
    
    var delegate: FavoriteMovieViewModelDelegate?
    
    func saveFavoriteMovie(with context: NSManagedObjectContext) {
        guard let favoriteMovie = movie else {
            return
        }
        
        let saveMovie = FavoriteMovie(context: context)
        saveMovie.coverFavoriteMovie = favoriteMovie.posterPath
        saveMovie.released = favoriteMovie.releaseDate
        saveMovie.titleFavoriteMovie = favoriteMovie.title
        saveMovie.subTitleFavoriteMovie = favoriteMovie.overview
        
        favoriteMovieManager.saveFavoriteMovie(with: context) { (result) in
            switch result{
            case .success(_):
                print("save")
                self.delegate?.didChangedFavorites()
            case .failure(_):
                print("error")
            }
        }
        
    }
    
    func loadFavoriteMovies(with context: NSManagedObjectContext)  {
        favoriteMovieManager.loadFavoriteMovie(with: context) { (result) in
            switch result{
            case .success(let favorites):
                guard let favorites = favorites else { return }
                self.favoritesMovies = favorites
            case .failure(let error):
                print(error as Any)
            }

        }
    }
    
    func unfavoriteMovie(with context: NSManagedObjectContext, index: Int )  {
        favoriteMovieManager.deleteFavoriteMovie(index: index, context: context) { (result) in
            switch result{
            case .success(_):
                print("")
            case .failure(_):
                print("")
            }
        }
    }
}
