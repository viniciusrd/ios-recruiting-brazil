//
//  QueryMovie.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
struct QueryMovie {
    let language: String
    let page: Int
    let adult: Bool
    let query: String
    
    init(language: String, page: Int, adult: Bool, query: String) {
        self.language = language
        self.page = page
        self.adult = adult
        self.query = query
    }
}
