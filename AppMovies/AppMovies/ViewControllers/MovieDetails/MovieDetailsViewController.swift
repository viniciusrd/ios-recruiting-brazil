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
    
    var viewModel: MovieDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
        
        SVProgressHUD.show()
        viewModel.movieDetails { (complete) in
            SVProgressHUD.dismiss()
        }
    }

}
