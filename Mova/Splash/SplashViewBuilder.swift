//
//  LaunchViewBuilder.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 09/04/2026.
//

import UIKit

final class SplashViewBuilder {
    
    static func build() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "SplashViewController"
        ) as? SplashViewController else {
            fatalError("SplashViewController not found in Splash.storyboard")
        }
        
        let viewModel = SplashViewModel()
        vc.viewModel = viewModel
        
        return vc
    }
}
