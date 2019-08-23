//
//  MoviesCoordinator.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 20/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
import SVProgressHUD

class MoviesCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var storyboardIdentifier = "Movies"
    
    private(set) var movieAPI: APIMovieProtocol = APIMovieDefault()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let tabViewController = UIStoryboard(name: storyboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: "MovieTabBarController") as? UITabBarController{
           self.navigationController.pushViewController(tabViewController, animated: true)
            SVProgressHUD.show()
            movieAPI.movies(forPage: "500000", forLanguage: "en-US") { (response) in
                SVProgressHUD.dismiss()
            }
        }
    }
}
