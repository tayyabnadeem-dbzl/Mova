//
//  PlayTableViewModelCell.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 23/04/2026.
//

import Foundation

struct PlayTableCellViewModel: CellViewModel, Hashable, Sendable {
    let id: Int
    let title: String
    let date: String
    let episode: String
    let status: String
    let imageURL: String

    let reuseIdentifier = "PlayTableViewCell"
}
