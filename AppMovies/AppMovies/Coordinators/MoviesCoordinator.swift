//
//  MoviesCoordinator.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 20/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
class MoviesCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var storyboardIdentifier = "Movies"
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let tabViewController = UIStoryboard(name: storyboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: "MovieTabBarController") as? UITabBarController{
           self.navigationController.pushViewController(tabViewController, animated: true)
        }
    }
}
