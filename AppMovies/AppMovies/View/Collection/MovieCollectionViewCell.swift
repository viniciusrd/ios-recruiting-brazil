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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivCoverMovie.layer.masksToBounds = true
        ivCoverMovie.layer.cornerRadius = 5.0
    }
    
    @IBAction func touchFavorite(_ sender: UIButton) {
        print("ANY")
    }
    
}
