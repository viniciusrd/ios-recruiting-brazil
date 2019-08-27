//
//  MovieTabBarViewController.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

protocol MovieTabBarViewControllerDelegate {
    func searchBarSearchText(type: Type,textDidChange searchText: String, viewController: UIViewController)
    func setDefaultMovies(type: Type)
}

enum Type {
    case popularMovies
    case favoriteMovies
}

class MovieTabBarViewController: UITabBarController {
    
    var movieTabBardelegate: MovieTabBarViewControllerDelegate?
    var searchText = ""
    var typeSelected: Type = .popularMovies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUi()
    }
    
    func setupUi()  {
        self.delegate = self
        self.tabBar.barTintColor = UIColor(red: 255/255.0, green: 214/255.0, blue: 10/255.0, alpha: 0.0)
        let imageSearch = UIImage(named: "icSearchCopy")
        let searchBarButtonItem = UIBarButtonItem(image: imageSearch, style: .done, target: self, action: #selector(self.createSearchBar))
        self.navigationItem.setRightBarButton(searchBarButtonItem, animated: true)
        self.navigationItem.rightBarButtonItem?.style = .plain
    }
    
    @objc func createSearchBar()  {
        
        let searchBar = UISearchBar()
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.barTintColor = .black
        searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchBar
        self.navigationItem.setRightBarButton(nil, animated: true)
    }
    
}

extension MovieTabBarViewController: UITabBarControllerDelegate{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if ((viewController as? MoviesViewController) != nil){
            typeSelected = .popularMovies
        }else if ((viewController as? MoviesFavoritesViewController) != nil){
            typeSelected = .favoriteMovies
        }
    }
}

extension MovieTabBarViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        print(self.searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if !searchText.isEmpty{
            self.movieTabBardelegate?.searchBarSearchText(type: self.typeSelected, textDidChange: searchText, viewController: self)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        UIView.transition(with: self.view, duration: 2.5, options: .transitionCrossDissolve, animations: {
            searchBar.isHidden = true
            self.setupUi()
            self.view.layoutIfNeeded()
        })
        searchBar.resignFirstResponder()
        self.searchText = ""
        self.movieTabBardelegate?.setDefaultMovies(type: self.typeSelected)
    }
}
