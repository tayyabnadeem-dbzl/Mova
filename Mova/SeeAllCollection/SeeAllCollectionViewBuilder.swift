//
//  SeeAllCollectionViewBuilder.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 17/04/2026.
//

import Foundation
import UIKit

final class SeeAllCollectionViewBuilder {

    static func build(title: String) -> UIViewController {

        let storyboard = UIStoryboard(name: "SeeAllCollectionViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "SeeAllCollectionViewController"
        ) as? SeeAllCollectionViewController else {
            fatalError("SeeAllCollectionViewController not found in storyboard")
        }
        let service = MovieService()
        let viewModel = SeeAllCollectionViewModel(title: title, service: service)
        vc.viewModel = viewModel
        return vc
    }
}
