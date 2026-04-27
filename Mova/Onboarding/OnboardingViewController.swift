//
//  OnboardingViewController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 09/04/2026.
//

import Foundation
import UIKit

final class OnboardingViewController : UIViewController {
    
//MARK: - Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
// MARK: - Properties
    var viewModel: OnboardingViewModelType!
    private var gradientLayer: CAGradientLayer?

//MARK: - Constants
    private enum Constants {
        static let welcomeText = "Welcome to Mova"
        static let descriptionText = "The best movie streaming app of the century to make your days great!"
        static let getStarted = "Get Started"
    }
    
    @objc func startButtonTapped() {
        viewModel.didTapGetStarted()
    }
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        startButton.addTarget(self, action: #selector(startButtonTapped), for:.touchUpInside)
    }
}

//MARK: - Setup
private extension OnboardingViewController {
    func setupUI() {
        welcomeLabel.text = Constants.welcomeText
        descriptionLabel.text = Constants.descriptionText
        welcomeLabel.font = UIFont(name: "UrbanistRoman-Bold", size: 40)
        descriptionLabel.font = UIFont(name: "UrbanistRoman-Medium", size: 16)
        welcomeLabel.textColor = .white
        descriptionLabel.textColor = .white
        startButton.setTitle(Constants.getStarted, for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.appRed
        startButton.layer.cornerRadius = 100
        startButton.clipsToBounds = true
        startButton.configuration?.titleTextAttributesTransformer =
        UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "UrbanistRoman-Bold", size: 15)
            return outgoing
        }
       backgroundImageView.contentMode = .scaleAspectFill
   }
}

extension OnboardingViewController {
    internal override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if gradientLayer == nil {
            let gradient = CAGradientLayer()
            gradient.frame = gradientView.bounds
            gradient.colors = [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.5).cgColor,
                UIColor.black.cgColor
            ]
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradientView.layer.addSublayer(gradient)
            gradientLayer = gradient
            gradientLayer?.opacity = 0.9
        } else {
            gradientLayer?.frame = gradientView.bounds
        }
    }
}

// MARK: - Binding
private extension OnboardingViewController {
    func bindViewModel() {
        viewModel.onGetStarted = { [weak self] in
            self?.navigateToOptionSignup()
        }
    }
}

private extension OnboardingViewController {
    func navigateToOptionSignup() {
        let vc = OptionsSignupViewBuilder.build()
        navigationController?.pushViewController(vc, animated: true)
    }
}
