//
//  MovieTabBarViewController.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

protocol MovieTabBarViewControllerDelegate {
    func searchBarTextDidChange(textDidChange searchText: String, viewController: UIViewController)
}

class MovieTabBarViewController: UITabBarController {

    var movieTabBardelegate: MovieTabBarViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
    }
    
    func setupUi()  {
        self.tabBar.isTranslucent = true
        self.tabBar.barTintColor = UIColor(red: 255/255.0, green: 214/255.0, blue: 10/255.0, alpha: 0.0)
        
        let imageSearch = UIImage(named: "search_icon")
        let searchBarButtonItem = UIBarButtonItem(image: imageSearch, style: .done, target: self, action: #selector(self.createSearchBar))
        self.navigationItem.setRightBarButton(searchBarButtonItem, animated: true);
    }
    
    @objc func createSearchBar()  {
        
        let searchBar = UISearchBar()
        searchBar.setShowsCancelButton(true, animated: true)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancelar"
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.barTintColor = .black
        self.navigationItem.titleView = searchBar
        self.navigationItem.setRightBarButton(nil, animated: true)
    }
    
}

extension MovieTabBarViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieTabBardelegate?.searchBarTextDidChange(textDidChange: searchText, viewController: self)
    }
}
