//
//  HomeViewBuilder.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 15/04/2026.
//

import Foundation
import UIKit

final class HomeViewBuilder {

    static func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(
            identifier: "HomeViewController"
        ) as? HomeViewController else {
            fatalError("HomeViewController not found in Home storyboard")
        }
        let viewModel = HomeViewModel()
        vc.viewModel = viewModel
        return vc
    }
}
