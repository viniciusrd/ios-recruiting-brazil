//
//  Genre.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
struct Genre: Codable {
    let id: Int
    let name: String
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
