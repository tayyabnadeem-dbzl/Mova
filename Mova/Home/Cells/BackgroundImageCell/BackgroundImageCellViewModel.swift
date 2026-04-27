//
//  BackgroundImageCellViewModel.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 16/04/2026.
//

import Foundation

struct BackgroundImage {
    let imageName: String
    let title: String
    let genre: String
    let playTitle: String
    let listTitle: String
}

final class BackgroundImageCellViewModel : CellViewModel {
    
    //MARK: - Properties
    var reuseIdentifier: String {
        "BackgroundImageCellController"
    }
    let imageName: String
    let title: String
    let genre: String
    let playTitle: String
    let listTitle: String
    
    //MARK: - init
    init(banner: Banner) {
        self.imageName = banner.image
        self.title = banner.title
        self.genre = banner.genre
        self.playTitle = banner.playTitle
        self.listTitle = banner.listTitle
    }
}
