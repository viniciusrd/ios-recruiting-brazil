//
//  Language.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
struct Language: Codable {
    let id:String
    let name:String
    enum CodingKeys: String, CodingKey {
        case id = "iso_639_1"
        case name = "name"
    }
}
