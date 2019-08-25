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
    @IBOutlet weak var constraintTopStackInfo: NSLayoutConstraint!
    @IBOutlet weak var svInfo: UIStackView!
    @IBOutlet weak var svOverview: UIStackView!
    
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

    
    func setupUI(){
        
        self.ivCoverMovie.isHidden = true
        self.svInfo.isHidden = true
        self.svOverview.isHidden = true
        self.constraintTopStackInfo.constant = 0
        
        self.lbTitle.alpha = 0.0
        self.lbSubtitle.alpha = 0.0
        self.lbStatus.alpha = 0.0
        self.lbReleased.alpha = 0.0
        
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
                    
                    UIView.transition(with: self.view, duration: 2.5, options: .transitionCrossDissolve, animations: {
                        self.ivCoverMovie.isHidden = false
                        UIView.animate(withDuration: 2.5) {
                            
                            self.constraintTopStackInfo.constant = -60
                            self.svInfo.isHidden = false
                            self.svOverview.isHidden = false
                            self.lbTitle.alpha = 1.0
                            self.lbSubtitle.alpha = 1.0
                            self.lbStatus.alpha = 1.0
                            self.lbReleased.alpha = 1.0
                            
                            self.view.layoutIfNeeded();
                        }
                    })
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

    @IBAction func touchedMoreAbout(_ sender: Any) {
    }
}
