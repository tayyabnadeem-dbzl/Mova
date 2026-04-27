//
//  PlayViewBuilder.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 23/04/2026.
//

import Foundation
import UIKit

final class PlayViewBuilder {

    static func build(title: String) -> UIViewController {

        let storyboard = UIStoryboard(name: "PlayViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(
            identifier: "PlayViewController"
        ) as? PlayViewController else {
            fatalError("View Controller not found")
        }
        let service = MovieService()
        let viewModel = PlayViewModel(title: title, service: service)
        vc.viewModel = viewModel
        return vc
    }
}
