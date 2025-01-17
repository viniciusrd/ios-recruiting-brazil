//
//  MoviesViewController.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 20/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
import SVProgressHUD


protocol MoviesViewControllerDelegate: class {
    func didTapShowMovieDetails(withMovie movie: Movie , viewController: MoviesViewController)
    func didTapAddFavoriteMovie(withMovie movie: Movie, viewController: MoviesViewController)
}
class MoviesViewController: BaseViewController {

    @IBOutlet weak var movieCollection: UICollectionView!
    
    private let reuseIdentifier = "MovieCollectionViewCell"

    var viewModel: MovieViewModel!
    var delegate: MoviesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        setupUI()
    }
    
    func setupUI(){
        self.tabBarController?.title = "Popular Movies"
        self.tabBarItem = UITabBarItem(title: TabBarItem.movies.rawValue, image: #imageLiteral(resourceName: "list_icon"), selectedImage:  #imageLiteral(resourceName: "list_icon"))
        self.tabBarItem.badgeColor = .black
        
        movieCollection.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        SVProgressHUD.show()
        viewModel.popularMovies { (movies) in
            SVProgressHUD.dismiss()
            self.onChangedMovies()
        }
    }
    
    func onChangedMovies()  {
        DispatchQueue.main.async {
            self.movieCollection.reloadData()
        }
    }

}

// MARK: - UICollectionViewDelegate

extension MoviesViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let movie =  viewModel.movies[indexPath.row]
        self.delegate?.didTapShowMovieDetails(withMovie: movie, viewController: self)
    }
}

// MARK: - UICollectionViewDataSource

extension MoviesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.numberOfMovies() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        let movie = viewModel.movies[indexPath.row]
        cell.setupMovieCell(withMovie: movie)
        cell.actionBlock = {
            self.delegate?.didTapAddFavoriteMovie(withMovie: movie, viewController: self)
        }
        return cell
    }
}

// MARK: - MovieViewModelDelegate

extension MoviesViewController: MovieViewModelDelegate{
    func didChangedMovies() {
        self.onChangedMovies()
    }
    
    func startRequest() {
        SVProgressHUD.show()
    }
    
    func endRequest() {
        SVProgressHUD.dismiss()
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    ///Set  size of the cell for collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 16
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 250)
    }
}
