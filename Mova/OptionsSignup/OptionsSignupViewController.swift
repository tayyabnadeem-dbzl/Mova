//
//  SignupViewController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 09/04/2026.
//

import Foundation
import UIKit

enum AuthEntryPoint {
    case options
    case signup
    case login
}

struct SocialButtonStyle {
    let title: String
    let imageName: String
    let backgroundColor: UIColor
    let textColor: UIColor
}

private enum SocialStyles {
    static let facebook = SocialButtonStyle (
        title: "Continue with Facebook",
        imageName: "facebook-logo",
        backgroundColor: .white,
        textColor: .black
    )
    static let google = SocialButtonStyle (
        title: "Continue with Google",
        imageName: "google-logo",
        backgroundColor: .white,
        textColor: .black
    )
    static let apple = SocialButtonStyle(
        title: "Continue with Apple",
        imageName: "apple-logo",
        backgroundColor: .white,
        textColor: .black
    )
}

final class OptionsSignupViewController : UIViewController{
     // MARK: - Outlets
    @IBOutlet weak var OptionsSignupImageView : UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var rightBarView: UIView!
    @IBOutlet weak var leftBarView: UIView!
    @IBOutlet weak var connectWithAppleButton: UIButton!
    @IBOutlet weak var connectWithGoogleButton: UIButton!
    @IBOutlet weak var connectWithFacebookButton: UIButton!
    @IBOutlet weak var SigninButton: UIButton!
    @IBOutlet weak var signupOptionLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Properties
    var viewModel:
        OptionsSignupViewModelType!

    //MARK: - Constants
    private enum Constants {
       static let welcomeText = "Let's you in"
        static let signinWithPassword = "Sign in with password"
        static let signupOptionLabel = "Don't have an account? Sign up"
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        setupUI()
        setupAttributedLabel()
        SigninButton.addTarget(self, action: #selector(signinButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action:                 #selector(handleLabelTap(_:)))
        signupOptionLabel.addGestureRecognizer(tapGesture)

        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func signinButtonTapped(){
        viewModel.didTapLogin()
    }
    @objc func signupClickableLabelTapped(){
        viewModel.didTapSignup()
    }
    @objc private func backButtonTapped(){
        viewModel.didTapBack()
    }
    @objc private func handleLabelTap(_ gesture: UITapGestureRecognizer) {

        if didTapAttributedText(in: signupOptionLabel,
                                gesture: gesture,
                                targetText: "Sign up") {

            let vc = SignupViewBuilder.build()
            navigationController?.pushViewController(vc, animated: true)
        
        }
    }
}

//MARK: - Actions
private extension OptionsSignupViewController {
    
    func setupSignupClickableLabelTap() {
        signupOptionLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(signupClickableLabelTapped))
        signupOptionLabel.addGestureRecognizer(tap)
    }
    
}

//MARK: - Setup
private extension OptionsSignupViewController {
    func setupUI() {
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize.width = scrollView.frame.size.width
        welcomeLabel.text = Constants.welcomeText
        welcomeLabel.font = .systemFont(ofSize: 45, weight: .bold)
        welcomeLabel.textColor = UIColor.signupText
        OptionsSignupImageView.image = UIImage(named: "options-signup-image")
        OptionsSignupImageView.contentMode = .scaleAspectFit
        setupButtons()
        leftBarView.backgroundColor = UIColor.black.withAlphaComponent(0.20)
        rightBarView.backgroundColor = UIColor.black.withAlphaComponent(0.20)
        orLabel.text = "or"
        orLabel.textColor = UIColor.black.withAlphaComponent(0.75)
        signupOptionLabel.text = Constants.signupOptionLabel
        SigninButton.setTitle(Constants.signinWithPassword, for: .normal)
        SigninButton.setTitleColor(.white, for: .normal)
        SigninButton.backgroundColor = UIColor.appRed
        SigninButton.clipsToBounds = true
        SigninButton.configuration?.titleTextAttributesTransformer =
        UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            
            return outgoing
        }
    }
    func setupBackButton() {
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(
            image: UIImage(named: "back-arrow")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
        navigationItem.leftBarButtonItem = backButton
    }
}

private extension OptionsSignupViewController {
    private func setupButtons() {
        configureButton(connectWithFacebookButton, with: SocialStyles.facebook)
        configureButton(connectWithGoogleButton, with: SocialStyles.google)
        configureButton(connectWithAppleButton, with: SocialStyles.apple)
    }
}

private extension OptionsSignupViewController {
    private func configureButton(
        _ button: UIButton,
        with style: SocialButtonStyle
    ) {
        var config = UIButton.Configuration.filled()
        config.title = style.title
        config.image = UIImage(named: style.imageName)
        config.imagePlacement = .leading
        config.imagePadding = 10
        config.baseBackgroundColor = style.backgroundColor
        config.baseForegroundColor = style.textColor
        config.background.cornerRadius = 16
        config.background.strokeColor = UIColor.black.withAlphaComponent(0.15)
        button.configuration = config
    }
}

//MARK: - Binding
private extension OptionsSignupViewController {
    func bindViewModel() {
        viewModel.onBack = { [weak self] in
            self?.navigateToOnboarding()
        }
        viewModel.onSignup = { [weak self] in
            self?.navigateToSignup()
        }
        viewModel.onLogin = { [weak self] in
            self?.navigateToLogin()
        }
    }
}

//MARK: - Navigation
private extension OptionsSignupViewController {
    func navigateToOnboarding() {
        navigationController?.popViewController(animated: true)
    }
    func navigateToSignup() {
        navigationController?.goToSingleInstance(SignupViewController.self, create: {
            SignupViewBuilder.build() as! SignupViewController
        }, animated: true)
    }
    func navigateToLogin() {
        navigationController?.goToSingleInstance(
            LoginViewController.self,
            create: {
                LoginViewBuilder.build() as! LoginViewController
            },
            animated: true
        )    }
}

private extension OptionsSignupViewController {
    func setupAttributedLabel() {
        signupOptionLabel.isUserInteractionEnabled = true
        let attributedString = NSMutableAttributedString(string: Constants.signupOptionLabel)
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: Constants.signupOptionLabel.count))
        let signupRange = (Constants.signupOptionLabel as NSString).range(of: "Sign up")
        attributedString.addAttributes([
            .foregroundColor: UIColor.red,
            .font: UIFont.boldSystemFont(ofSize: 15)
        ], range: signupRange)

        signupOptionLabel.attributedText = attributedString
    }
}

private extension OptionsSignupViewController {
    private func didTapAttributedText(
        in label: UILabel,
        gesture: UITapGestureRecognizer,
        targetText: String
    ) -> Bool {

        guard let labelText = label.attributedText?.string else { return false }

        let nsText = labelText as NSString
        let targetRange = nsText.range(of: targetText)

        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.lineBreakMode = label.lineBreakMode

        let location = gesture.location(in: label)
        let index = layoutManager.characterIndex(
            for: location,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )

        return NSLocationInRange(index, targetRange)
    }
}

extension UINavigationController {

    func goToSingleInstance<T: UIViewController>(
        _ type: T.Type,
        create: () -> T,
        animated: Bool
    ) {

        var stack = viewControllers

        // remove existing instance if it exists
        stack.removeAll { $0 is T }

        // append new instance
        let newVC = create()
        stack.append(newVC)

        setViewControllers(stack, animated: animated)
    }
}
