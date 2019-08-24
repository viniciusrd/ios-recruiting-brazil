//
//  Constants.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation

enum TypeImage {
    case compressedImage
    case fullImage
}

struct Constants {

    static let scheme = "https"
    static let movieHost = "api.themoviedb.org"
    static let movieVersionAPI = "/3"
    static let movieApiKey = "564c8466dee585ae1bd14b65b40c5241"
    
    static func movieImageHost(type: TypeImage) -> String{
        var path = ""
        switch type{
        case .compressedImage:
            path = "w500/"
        case .fullImage:
            path = "original/"
        }
        return "https://image.tmdb.org/t/p/"+path
    }
}
