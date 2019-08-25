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

        createDefaultToolbar()
        
    }
    
    static func initFromStoryboard(named storyboardName: String) -> Self {
        return initFromStoryboardHelper(storyboardName: storyboardName)
    }
    
    private class func initFromStoryboardHelper<T>(storyboardName: String) -> T {
        
        let storyoard = UIStoryboard(name: storyboardName, bundle: nil)
        let className = String(describing: self)
        let viewController = storyoard.instantiateViewController(withIdentifier: className) as! T
        return viewController
    }

//    //Cria a toolbar padrao
    func createDefaultToolbar()  {
        self.setColorNavigationBar();

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

    }
//
    //Seta a cor da toolbar
    func setColorNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 255/255.0, green: 214/255.0, blue: 10/255.0, alpha: 0.0)
        UINavigationBar.appearance().tintColor = .white
    }
    
}
