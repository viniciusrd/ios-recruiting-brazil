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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
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
    func createDefaultToolbar(){
        self.setColorNavigationBar();
    }
//
    //Seta a cor da toolbar
    func setColorNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 255/255.0, green: 214/255.0, blue: 10/255.0, alpha: 0.0)
        UINavigationBar.appearance().tintColor = .black
    }
    
}
