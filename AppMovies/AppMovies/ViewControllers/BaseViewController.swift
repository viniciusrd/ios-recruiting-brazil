//
//  BaseViewController.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 21/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

//    //Cria a toolbar padrao
//    func createDefaultToolbar()  {
//        self.setColorNavigationBar();
//
//        let navController = navigationController!
//
//        let image = UIImage(named: "logoNav.png") //Your logo url here
//        let imageView = UIImageView(image: image)
//
//        let bannerWidth = navController.navigationBar.frame.size.width
//        let bannerHeight = navController.navigationBar.frame.size.height
//
//        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
//        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
//
//        imageView.frame = CGRect(x: bannerX, y: bannerY, width: 102.7, height: 25)
//        imageView.contentMode = .center
//
//        navigationItem.titleView = imageView
//
//        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "icSearchCopy"), style: .plain, target: self, action: #selector(HomeViewController.createSearchBar))
//        self.navigationItem.setRightBarButton(searchBarButtonItem, animated: true);
//
//    }
//
//    //Seta a cor da toolbar
//    func setColorNavigationBar() {
//        UINavigationBar.appearance().barTintColor = UIColor(red: 222/255.0, green: 71/255.0, blue: 114/255.0, alpha: 0.0)
//        UINavigationBar.appearance().tintColor = .white
//    }
    
}