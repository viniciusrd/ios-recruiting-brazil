//
//  MoviesCoordinator.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 20/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

enum TabBarItem: String {
    case movies = "Movies"
    case favorites = "Favorites"
}

class MoviesCoordinator: Coordinator {
    
    let movieViewModel: MovieViewModel
    let favoriteMovieViewModel: FavoriteMovieViewModel
    
    var controllers: [UIViewController] = []
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var storyboardIdentifier = "Movies"
    var selectedFavoriteMovie: Movie?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        movieViewModel = MovieViewModel(defaultPagination: Pagination(page: 1, totalResults: 0, totalPage: 0))
        favoriteMovieViewModel = FavoriteMovieViewModel()
    }
    
    func start() {
        showTabBarViewController()
    }
    
    func showTabBarViewController() {
        showMoviesViewController()
        showFavoritesMoviesViewController()
        let tabViewController = MovieTabBarViewController()
        tabViewController.movieTabBardelegate = self
        tabViewController.viewControllers = controllers
        self.navigationController.pushViewController(tabViewController, animated: true)
    }
    
    func showMoviesViewController()  {
        let moviesViewController = MoviesViewController.initFromStoryboard(named: storyboardIdentifier)
        moviesViewController.delegate = self
        moviesViewController.viewModel = movieViewModel
        controllers.append(moviesViewController)
    }
    
    func showFavoritesMoviesViewController() {
        let favoriteMovieViewController = MoviesFavoritesViewController.initFromStoryboard(named: storyboardIdentifier)
        favoriteMovieViewController.favoriteMovieViewModel = favoriteMovieViewModel
        favoriteMovieViewController.delegate = self
        controllers.append(favoriteMovieViewController)
    }
    
    func showMovieDetailsViewController(forMovie movie: Movie? = nil, forId id: Int? = nil)  {
        let movieDetailsViewController = MovieDetailsViewController.initFromStoryboard(named: storyboardIdentifier)
        let movieDetailViewModel: MovieDetailsViewModel
        if movie == nil{
            movieDetailViewModel = MovieDetailsViewModel(forMovieId: Int(id ?? 0))
        }else{
            movieDetailViewModel = MovieDetailsViewModel(forMovieId: movie?.id ?? 0)
        }
        movieDetailsViewController.viewModel = movieDetailViewModel
        movieDetailsViewController.delegate = self
        self.navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}

extension MoviesCoordinator: MovieTabBarViewControllerDelegate{
    func setDefaultMovies(type: Type) {
        switch type{
        case .popularMovies:
            self.movieViewModel.popularMovies { (_) in }
        case .favoriteMovies:
            self.favoriteMovieViewModel.loadFavoriteMovies(with: context)
        }
    }
    
    func searchBarSearchText(type: Type, textDidChange searchText: String, viewController: UIViewController) {
        switch type{
        case .popularMovies:
            self.movieViewModel.searchMovie(searchText: searchText)
        case .favoriteMovies:
            print("favoriteMovies")
            self.favoriteMovieViewModel.searchMovie(searchText: searchText)
        }
    }
}

extension MoviesCoordinator: MoviesViewControllerDelegate{
    func didTapAddFavoriteMovie(withMovie movie: Movie, viewController: MoviesViewController) {
        guard let titleMovie = movie.title else { return }
        let alert = Alert(withTitle: "Favorite Movie", withMessage: "Do you want add \(titleMovie) with a favorite movie?")
        alert.delegate = self
        self.selectedFavoriteMovie = movie
        self.navigationController.present(alert.show(), animated: true, completion: nil)
    }
    
    func didTapShowMovieDetails(withMovie movie: Movie, viewController: MoviesViewController) {
        self.showMovieDetailsViewController(forMovie: movie)
    }
}

extension MoviesCoordinator: MoviesFavoritesViewControllerDelegate{
    func didTapShowMovieDetails(withMovie movie: FavoriteMovie, viewController: MoviesFavoritesViewController) {
        self.showMovieDetailsViewController(forId: Int(movie.iDfavoriteMovie ?? "0"))
    }
    
    
}

extension MoviesCoordinator: MovieDetailsViewControllerDelegate{
    func errorMovieDetails() {
    }
    
    func didTapMoreAbout(forUrl url: String, viewController: UIViewController) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}

extension MoviesCoordinator: AlertDelegate{
    func didTapCancel() {
        //Do nothing
    }
    
    func didTapAccept() {
        //show te favorites
        guard let favoriteMovie = self.selectedFavoriteMovie else { return }
        self.favoriteMovieViewModel.movie = favoriteMovie
        self.favoriteMovieViewModel.saveFavoriteMovie(with: context)
        self.favoriteMovieViewModel.loadFavoriteMovies(with: context)
    }
    
    
}
