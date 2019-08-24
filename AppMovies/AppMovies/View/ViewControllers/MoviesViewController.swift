//
//  MoviesViewController.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 20/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
protocol MoviesViewControllerDelegate: class {
    func didTapMovie()
}
class MoviesViewController: BaseViewController {

    @IBOutlet weak var movieCollection: UICollectionView!
    
    private let reuseIdentifier = "MovieCollectionViewCell"
    var delegate: MoviesViewControllerDelegate?
    var items = [1,2,3,4,5,1,1,1,1,1,1,1,1]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 
        movieCollection.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
//        movieCollection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        movieCollection.register(MovieCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
//        movieCollection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
////        layout.scrollDirection  = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        movieCollection.setCollectionViewLayout(layout, animated: true)
//        movieCollection.reloadData()
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

extension MoviesViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        delegate?.didTapMovie()
    }
}

extension MoviesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
//        cell.ivCoverMovie.image = UIImage(named: "movie_cover")
        cell.lbTitleMovie?.text = "Teste"
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    ///Set  size of the cell for collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 16
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 250)
    }
}
