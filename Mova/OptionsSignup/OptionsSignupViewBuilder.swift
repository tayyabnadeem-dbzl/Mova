//
//  SignViewBuilder.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 09/04/2026.
//

import Foundation
import UIKit
final class OptionsSignupViewBuilder {
    
    static func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "OptionsSignup", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "OptionsSignupViewController") as? OptionsSignupViewController else {
            fatalError(
            "viewcontroller not found")
        }
        let viewModel = OptionsSignupViewModel()
        vc.viewModel = viewModel
        return vc
    }
}
