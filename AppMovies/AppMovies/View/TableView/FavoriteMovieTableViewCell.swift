//
//  FavoriteMovieTableViewCell.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 25/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
import Foundation

class FavoriteMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivCoverMovie: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubTitle: UILabel!
    @IBOutlet weak var lbReleased: UILabel!
    
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivCoverMovie.layer.masksToBounds = true
        ivCoverMovie.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupFavoriteMovieCell(withMovie favorite: FavoriteMovie)  {
        if let posterURL =  favorite.coverFavoriteMovie {
            ivCoverMovie.setImageFromURL(toPath: posterURL, toType: .compressedImage, completion: { (complete) in
                DispatchQueue.main.async() {
                    if complete, self.aiLoading.isAnimating{
                        self.aiLoading.stopAnimating()
                        self.aiLoading.isHidden = true
                    }
                }
            })
        }else{
            ivCoverMovie.isHidden = true
        }
        
        lbTitle.text = favorite.titleFavoriteMovie
        lbReleased.text = favorite.subTitleFavoriteMovie
        lbSubTitle.text = String(favorite.released?.prefix(4) ?? "")
    }
    
}
