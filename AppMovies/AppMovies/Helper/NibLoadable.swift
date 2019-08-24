//
//  NibLoadable.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 23/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static var defaultNibName: String { get }
    static func loadFromNib() -> Self
}

extension NibLoadable where Self: UIView {
    
    static var defaultNibName: String {
        return String(describing: self)
    }
    
    static var defaultNib: UINib {
        return UINib(nibName: defaultNibName, bundle: nil)
    }
    
    static func loadFromNib() -> Self {
        guard let nib = Bundle.main.loadNibNamed(defaultNibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("[NibLoadable] Cannot load view from nib.")
        }
        return nib
    }
    
}
