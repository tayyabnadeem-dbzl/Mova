//
//  LaunchViewModel.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 09/04/2026.
//

import Foundation

protocol SplashViewModelType {
    var onFinish : ((SplashViewModelAction) -> Void)? { get set }
    func start()
}

enum SplashViewModelAction {
    case onboarding
    case authOptions
    case home
}

enum StorageKeys {
    static let loggedInUser = "loggedInUser"
    static let hasSeenOnboarding = "HasSeenOnboarding"
}

final class SplashViewModel: SplashViewModelType {
    
    //MARK: - Properties
    var onFinish: ((SplashViewModelAction) -> Void)?
    
    func start() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let hasSeenOnboarding = UserDefaults.standard.bool(forKey: StorageKeys.hasSeenOnboarding)
            let loggedInUser = UserDefaults.standard.string(forKey: StorageKeys.loggedInUser)
            let isLoggedIn = !(loggedInUser?.isEmpty ?? true)
            
            if !hasSeenOnboarding {
                self.onFinish?(.onboarding)
            } else if isLoggedIn {
                self.onFinish?(.home)
            } else {
                self.onFinish?(.authOptions)
            }
        }
    }
}
