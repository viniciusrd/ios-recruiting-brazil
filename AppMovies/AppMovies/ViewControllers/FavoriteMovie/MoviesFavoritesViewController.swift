//
//  MoviesFavoritesViewController.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 20/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class MoviesFavoritesViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarItem = UITabBarItem(title: TabBarItem.favorites.rawValue, image: #imageLiteral(resourceName: "favorite_empty_icon"), selectedImage:  #imageLiteral(resourceName: "favorite_empty_icon"))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
