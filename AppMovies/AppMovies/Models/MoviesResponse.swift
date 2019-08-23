//
//  moviesResponse.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 22/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
struct MoviesResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPage: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPage = "total_pages"
        case movies = "results"
    }
}
