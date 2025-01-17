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
    var favoritesMoviesFiltered = [FavoriteMovie]()
    
    var delegate: FavoriteMovieViewModelDelegate?
    
    func saveFavoriteMovie(with context: NSManagedObjectContext) {
        guard let favorite = movie else {
            return
        }
        
        let saveMovie = FavoriteMovie(context: context)
        saveMovie.iDfavoriteMovie = String(favorite.id)
        saveMovie.coverFavoriteMovie = favorite.posterPath
        saveMovie.released = favorite.releaseDate
        saveMovie.titleFavoriteMovie = favorite.title
        saveMovie.subTitleFavoriteMovie = favorite.overview
        
        favoriteMovieManager.saveFavoriteMovie(with: context) { (result) in
            switch result{
            case .success(_):
                print("save")
                self.delegate?.didChangedFavorites()
            case .failure(let error):
                print(error as Any)
            }
        }
        
    }
    
    func searchMovie(searchText: String, completion: @escaping (Bool) -> Void) {
        favoritesMoviesFiltered = favoritesMovies.filter({ (favorite: FavoriteMovie) -> Bool in
            return (favorite.titleFavoriteMovie?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        if favoritesMoviesFiltered.count == 0 {
            completion(false)
        }
        favoritesMovies = favoritesMoviesFiltered
        self.delegate?.didChangedFavorites()
        completion(true)
    }
    
    func loadFavoriteMovies(with context: NSManagedObjectContext)  {
        favoriteMovieManager.loadFavoriteMovie(with: context) { (result) in
            switch result{
            case .success(let favorites):
                guard let favorites = favorites else { return }
                self.favoritesMovies = favorites
                self.delegate?.didChangedFavorites()
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
