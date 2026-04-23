//
//  PlayTableViewModelCell.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 23/04/2026.
//

import Foundation
struct PlayCellViewModel: TableCellViewModel {
    let reuseIdentifier: String = "PlayTableViewCell"
    
    let title: String
    let subtitle: String
    let date: String
    let imageURL: String
    let tagText: String
}
