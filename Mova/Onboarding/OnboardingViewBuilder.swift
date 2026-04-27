//
//  OnboardingViewBuilder.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 09/04/2026.
//

import Foundation
import UIKit

final class OnboardingViewBuilder {
    static func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController else {
            fatalError("OnboardingViewController not found")
        }
        let viewModel = OnboardingViewModel()
        vc.viewModel = viewModel
        return vc
    }
}
