//
//  Companies.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 24/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
struct Companies: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}
