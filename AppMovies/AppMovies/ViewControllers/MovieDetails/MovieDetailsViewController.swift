//
//  MovieDetailsViewController.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 20/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
import SVProgressHUD

class MovieDetailsViewController: BaseViewController {
    
    @IBOutlet weak var ivCoverMovie: UIImageView!
    @IBOutlet weak var aiLoadingCoverMovie: UIActivityIndicatorView!
    @IBOutlet weak var lbReleased: UILabel!
    @IBOutlet weak var lbRuntime: UILabel!
    @IBOutlet weak var cvRuntime: CardView!
    @IBOutlet weak var lbGenre: UILabel!
    
    @IBOutlet weak var lbVoteCount: UILabel!
    @IBOutlet weak var cvVoteCount: CardView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbOverwiew: UILabel!
    
    var viewModel: MovieDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func setColorNavigationBar() {
        super.setColorNavigationBar()
    }
    
    func setupUI(){
        setColorNavigationBar()
        aiLoadingCoverMovie.startAnimating()
        SVProgressHUD.show()
        viewModel.movieDetails { (_) in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.buildView()
            }
        }
    }
    
    func buildView(){
        guard let movieDetails = viewModel.movieDetails else { return }
        ivCoverMovie.layer.masksToBounds = true
        ivCoverMovie.layer.cornerRadius = 5.0
        ivCoverMovie.setImageFromURL(toPath: movieDetails.posterPath, toType: .fullImage) { (completed) in
            DispatchQueue.main.async {
                if completed, self.aiLoadingCoverMovie.isAnimating{
                    self.aiLoadingCoverMovie.startAnimating()
                    self.aiLoadingCoverMovie.isHidden = true
                }
            }
        }
        self.lbTitle.text = movieDetails.originalTitle
        self.lbSubtitle.text = movieDetails.tagline
        self.lbStatus.text = "\(movieDetails.status): "
        self.lbOverwiew.text = movieDetails.overview
        self.lbGenre.text = movieDetails.genres[0].name
        self.lbReleased.text = movieDetails.releaseDate
        self.lbRuntime.text = "\(movieDetails.runtime) min"
        self.lbVoteCount.text = String(movieDetails.voteCount)
    }

}
