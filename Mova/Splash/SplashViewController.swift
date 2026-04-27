//
//  LaunchViewController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 09/04/2026.
//

import Foundation
import UIKit


final class SplashViewController : UIViewController{
    
// MARK: - Outlets
    @IBOutlet weak var loaderImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    //MARK: - Properties
    var viewModel: SplashViewModelType!
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startRotation()
        bindViewModel()
        viewModel.start()
    }
}

private extension SplashViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        logoImageView.contentMode = .scaleAspectFit
        loaderImageView.contentMode = .scaleAspectFit
    }
}

private extension SplashViewController {

        func startRotation() {
            let rotation = CABasicAnimation(keyPath: "transform.rotation")
            rotation.toValue = Double.pi * 2
            rotation.duration = 1
            rotation.repeatCount = .infinity
            loaderImageView.layer.add(rotation, forKey: "rotation")
        }
}

private extension SplashViewController {
    private func bindViewModel() {
        viewModel.onFinish = { [weak self] action in
            switch action {
            case .onboarding:
                self?.navigateToOnboarding()
                
            case .authOptions:
                self?.navigateToAuthOptions()
                
            case .home:
                self?.navigateToHome()
            }
        }
    }
}
private extension SplashViewController {
    
    private func navigateToOnboarding() {
        let vc = OnboardingViewBuilder.build()
        navigationController?.setViewControllers([vc], animated: true)
    }

    private func navigateToAuthOptions() {
        let vc = OptionsSignupViewBuilder.build()
        navigationController?.setViewControllers([vc], animated: true)
    }

    private func navigateToHome() {
        AppRouter.showHome()
    }

}
