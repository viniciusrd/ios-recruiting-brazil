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
    
    var tabController: UITabBarController
    var controllers: [UIViewController] = []
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var storyboardIdentifier = "Movies"
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        tabController = UITabBarController()
    }
    
    func start() {
        showMoviesViewController()
        showFavoritesMoviesViewController()
        tabController.viewControllers = controllers
        tabController.tabBar.isTranslucent = false
        self.navigationController.pushViewController(tabController, animated: true)
    }
    
    func showMoviesViewController()  {
        let moviesViewController = MoviesViewController.initFromStoryboard(named: storyboardIdentifier)
        moviesViewController.tabBarItem = UITabBarItem(title: TabBarItem.movies.rawValue, image: #imageLiteral(resourceName: "list_icon"), selectedImage:  #imageLiteral(resourceName: "list_icon"))
        moviesViewController.delegate = self
        let movieViewModel = MovieViewModel(defaultPagination: Pagination(page: 1, totalResults: 0, totalPage: 0))
        moviesViewController.viewModel = movieViewModel
        controllers.append(moviesViewController)
    }
    
    func showFavoritesMoviesViewController() {
        let moviesViewController = MoviesFavoritesViewController.initFromStoryboard(named: storyboardIdentifier)
        moviesViewController.tabBarItem = UITabBarItem(title: TabBarItem.favorites.rawValue, image: #imageLiteral(resourceName: "favorite_empty_icon"), selectedImage:  #imageLiteral(resourceName: "favorite_empty_icon"))
        controllers.append(moviesViewController)
    }
    
    func showMovieDetailsViewController(forMovie movie: Movie)  {
        let movieDetailsViewController = MovieDetailsViewController.initFromStoryboard(named: storyboardIdentifier)
        let movieDetailViewModel = MovieDetailsViewModel(forMovie: movie)
        movieDetailsViewController.viewModel = movieDetailViewModel
        self.navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}

extension MoviesCoordinator: MoviesViewControllerDelegate{
    func didTapMovie(movie: Movie, viewController: MoviesViewController) {
        self.showMovieDetailsViewController(forMovie: movie)
    }
}
