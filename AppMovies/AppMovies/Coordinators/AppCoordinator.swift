//
//  AppCoordinator.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 20/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    let rootViewController: UINavigationController
    let moviesCoordinator: MoviesCoordinator
    
    init(window: UIWindow) {
        self.window = window;
        self.rootViewController = UINavigationController()
        self.moviesCoordinator = MoviesCoordinator(navigationController: self.rootViewController)
    }
    
    
    func start() {
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
        self.moviesCoordinator.start()
    }
}
