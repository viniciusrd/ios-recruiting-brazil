//
//  Pagination.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
struct Pagination{
    var page: Int
    var totalResults: Int
    var totalPage: Int
    
    init(page: Int, totalResults:Int, totalPage: Int) {
        self.page = page
        self.totalResults = totalResults
        self.totalPage = totalPage
    }
}
