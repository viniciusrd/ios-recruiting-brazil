//
//  MoviesCoordinator.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 20/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
import SVProgressHUD

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
    
    private(set) var movieAPI: APIMovieProtocol = APIMovieDefault()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        tabController = UITabBarController()
    }
    
    func start() {
//        if let tabViewController = UIStoryboard(name: storyboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: "MovieTabBarController") as? UITabBarController{
//           self.navigationController.pushViewController(tabViewController, animated: true)
//            SVProgressHUD.show()
//            movieAPI.movies(forPage: "1", forLanguage: "en-US") { (response) in
//                SVProgressHUD.dismiss()
//            }
//        }
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
        controllers.append(moviesViewController)
    }
    
    func showFavoritesMoviesViewController() {
        let moviesViewController = MoviesFavoritesViewController.initFromStoryboard(named: storyboardIdentifier)
        moviesViewController.tabBarItem = UITabBarItem(title: TabBarItem.movies.rawValue, image: #imageLiteral(resourceName: "favorite_empty_icon"), selectedImage:  #imageLiteral(resourceName: "favorite_empty_icon"))
        controllers.append(moviesViewController)
    }
    
    func showMovieDetailsViewController()  {
        let movieDetailsViewController = MovieDetailsViewController.initFromStoryboard(named: storyboardIdentifier)
        self.navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}

extension MoviesCoordinator: MoviesViewControllerDelegate{
    func didTapMovie() {
        self.showMovieDetailsViewController()
    }
    
    
}
