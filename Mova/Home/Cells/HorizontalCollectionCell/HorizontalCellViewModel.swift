//
//  HorizontalCellViewModel.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 16/04/2026.
//

import Foundation
enum HorizontalItem {
    case movie(MovieItem)
}

final class HorizontalCellViewModel : CellViewModel {
    var reuseIdentifier: String {
        "HorizontalCollectionCellController"
    }
 
    let title: String
    let items: [MovieItem]

    init(section: MovieSection) {
        self.title = section.title
        self.items = section.items
    }
    
    
    
    
}
