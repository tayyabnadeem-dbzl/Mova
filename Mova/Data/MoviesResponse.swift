//
//  Models.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 17/04/2026.
//

import Foundation

struct MoviesResponse: Decodable {
    let banner: Banner
    let sections: [MovieSection]
}

struct Banner: Decodable {
    let image: String
    let title: String
    let genre: String
    let playTitle: String
    let listTitle: String
}

struct MovieSection: Decodable {
    let title: String
    let items: [MovieItem]
}

struct MovieItem: Decodable {
    let image: String
    let rating: String
}
