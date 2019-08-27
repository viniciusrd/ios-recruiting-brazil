//
//  MoviesFavoritesViewController.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 20/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

protocol MoviesFavoritesViewControllerDelegate {
    func didTapShowMovieDetails(withMovie movie: FavoriteMovie , viewController: MoviesFavoritesViewController)
}

class MoviesFavoritesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let reuseIdentifier = "FavoriteMovieCell"
    var favoriteMovieViewModel: FavoriteMovieViewModel?
    
    var delegate: MoviesFavoritesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.title = "My Favorite Movies"
        favoriteMovieViewModel?.loadFavoriteMovies(with: context)
        favoriteMovieViewModel?.delegate = self
        self.tabBarItem = UITabBarItem(title: TabBarItem.favorites.rawValue, image: #imageLiteral(resourceName: "favorite_empty_icon"), selectedImage:  #imageLiteral(resourceName: "favorite_empty_icon"))
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
    func onChanged()  {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension MoviesFavoritesViewController: FavoriteMovieViewModelDelegate{
    func didChangedFavorites() {
        self.onChanged()
    }
}

extension MoviesFavoritesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favorite = self.favoriteMovieViewModel?.favoritesMovies[indexPath.row] else { return }
        self.delegate?.didTapShowMovieDetails(withMovie: favorite, viewController: self)
        print("You selected cell #\(indexPath.row)!")
    }
    
}

extension MoviesFavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteMovieViewModel?.favoritesMovies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell", for: indexPath) as! FavoriteMovieTableViewCell
        guard let favorite = self.favoriteMovieViewModel?.favoritesMovies[indexPath.row] else { return cell }
        cell.setupFavoriteMovieCell(withMovie: favorite)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.favoriteMovieViewModel?.unfavoriteMovie(with: context, index: indexPath.row)
            favoriteMovieViewModel?.loadFavoriteMovies(with: context)
            self.onChanged()
        }
    }
}

