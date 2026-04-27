//
//  OnboardingViewModel.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 09/04/2026.
//

import Foundation

protocol OnboardingViewModelType {
    var onGetStarted: (() -> Void)? { get set }
    func didTapGetStarted()
}

final class OnboardingViewModel: OnboardingViewModelType {
    var onGetStarted: (() -> Void)?
    func didTapGetStarted() {
        UserDefaults.standard.set(true, forKey: StorageKeys.hasSeenOnboarding)
        onGetStarted?()
    }
}
