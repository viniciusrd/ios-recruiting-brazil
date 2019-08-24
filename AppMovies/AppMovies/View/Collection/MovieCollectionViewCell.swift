//
//  MovieCollectionViewCell.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 21/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivCoverMovie: UIImageView!
    @IBOutlet weak var lbTitleMovie: UILabel!
    @IBOutlet weak var btFavoriteMovie: UIButton!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivCoverMovie.layer.masksToBounds = true
        ivCoverMovie.layer.cornerRadius = 5.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ivCoverMovie.image = nil
        lbTitleMovie.text = nil
    }
    
    func setupMovieCell(withMovie movie: Movie)  {
        ivCoverMovie.setImageFromURL(toPath: movie.posterPath, toType: .compressedImage, completion: { (complete) in
            DispatchQueue.main.async() {
                if complete, self.aiLoading.isAnimating{
                    self.aiLoading.stopAnimating()
                    self.aiLoading.isHidden = true
                }
            }
        })
        lbTitleMovie.text = movie.originalTitle
    }
    
    @IBAction func touchFavorite(_ sender: UIButton) {
        print("ANY")
        
    }
    
}
