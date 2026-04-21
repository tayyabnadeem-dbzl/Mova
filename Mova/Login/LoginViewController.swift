//
//  LoginViewController.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 14/04/2026.
//

import Foundation
import UIKit

final class LoginViewController : UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginBackgroundImageView: UIImageView!
    @IBOutlet weak var loginAccountLabel: UILabel!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextFieldImageView: UIImageView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFieldImageView: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeLabel: UILabel!
    @IBOutlet weak var signinButtonView: UIButton!
    @IBOutlet weak var leftBarView: UIView!
    @IBOutlet weak var rightBarView: UIView!
    @IBOutlet weak var orContinueWithLabel: UILabel!
    @IBOutlet weak var facebookButtonView: UIButton!
    @IBOutlet weak var googleButtonView: UIButton!
    @IBOutlet weak var appleButtonView: UIButton!
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var forgotPasswordButtonView: UIButton!
    @IBOutlet weak var checkboxButtonView: UIButton!
    @IBOutlet weak var hidePasswordImageView: UIImageView!
    
    //MARK: - Constants
    private enum Constants {
        static let SignupPageText = "Login to Your Account"
        static let optionsText = "Don’t have an account?"
        static let rememberMeText = "Remember me"
        static let forgotPassword = "Forgot the password?"
        static let orContinueWith = "or continue with"
        static let signinButtonText = "Sign in"
        static let signupLabel = "Don't have an account? Sign up"
    }
    
    //MARK: - Properties
    var viewModel: LoginViewModelType!
    private var isChecked = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        setupUI()
        setupCheckboxButton()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setupActions()
        setupAttributedLabel()
        bindViewModel()
        let tapGesture = UITapGestureRecognizer(target: self, action:                 #selector(handleLabelTap(_:)))
        signupLabel.addGestureRecognizer(tapGesture)
        
    }
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func toggleCheckbox() {
        isChecked.toggle()
        updateCheckboxUI()
    }
    @objc private func didTapEmailView() {
        emailTextField.becomeFirstResponder()
    }
    @objc private func didTapPasswordView() {
        passwordTextField.becomeFirstResponder()
    }
    @objc private func loginButtonTapped() {
        viewModel.login(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
    @objc private func handleLabelTap(_ gesture: UITapGestureRecognizer) {
        navigationController?.goToSingleInstance(SignupViewController.self, create: {
            SignupViewBuilder.build() as! SignupViewController
        }, animated: true)
    
    }
}

//MARK: - Binding
private extension LoginViewController {
    func bindViewModel() {
        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                self?.showAlert(message: message)
            }
        }
        viewModel.onLoginSuccess = { [weak self] username in
            DispatchQueue.main.async {
                self?.navigateToHome()
            }
        }
    }
}

//MARK: - Setup UI
private extension LoginViewController {
    func setupUI() {
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize.width = scrollView.frame.size.width
        loginBackgroundImageView.image = UIImage(named: "mova-icon")
        emailTextFieldImageView.image = UIImage(named: "Message")
        passwordTextFieldImageView.image = UIImage(named: "Lock")
        loginBackgroundImageView.contentMode = .scaleAspectFit
        loginAccountLabel.text = Constants.SignupPageText
        loginAccountLabel.font = .systemFont(ofSize: 32, weight: .bold)
        loginAccountLabel.textColor = UIColor.signupText
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textContentType = .emailAddress
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [.foregroundColor: UIColor.darkGray]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [.foregroundColor: UIColor.darkGray]
        )
        hidePasswordImageView.image = UIImage(named: "hide-icon")
        rememberMeLabel.text = Constants.rememberMeText
        signupLabel.text = Constants.signupLabel
        signupLabel.textColor = .lightGray
        signupLabel.font = .systemFont(ofSize: 15 , weight: .light)
        rememberMeLabel.font = .systemFont(ofSize: 15)
        emailView.backgroundColor = UIColor(named: "textfied-color")
        emailTextField.borderStyle = .none
        passwordView.backgroundColor = UIColor(named: "textfied-color")
        passwordTextField.borderStyle = .none
        passwordTextField.isSecureTextEntry = true
        emailView.layer.cornerRadius = 12
        passwordView.layer.cornerRadius = 12
        emailTextFieldImageView.tintColor = .lightGray
        passwordTextFieldImageView.tintColor = .lightGray
        hidePasswordImageView.tintColor = .lightGray
        makeViewFocusable(emailView, action: #selector(didTapEmailView))
        makeViewFocusable(passwordView, action: #selector(didTapPasswordView))
        leftBarView.backgroundColor = UIColor.black.withAlphaComponent(0.20)
        rightBarView.backgroundColor = UIColor.black.withAlphaComponent(0.20)
        orContinueWithLabel.text = Constants.orContinueWith
        orContinueWithLabel.textColor = UIColor.black.withAlphaComponent(0.75)
        forgotPasswordButtonView.setTitle(Constants.forgotPassword, for: .normal)
        forgotPasswordButtonView.setTitleColor(.appRed, for: .normal)
        forgotPasswordButtonView.configuration?.titleTextAttributesTransformer =
        UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            return outgoing
        }
        signinButtonView.setTitle(Constants.signinButtonText, for: .normal)
        signinButtonView.setTitleColor(.white, for: .normal)
        signinButtonView.backgroundColor = UIColor.buttonRed
        signinButtonView.clipsToBounds = true
        signinButtonView.layer.cornerRadius = 100
        signinButtonView.configuration?.titleTextAttributesTransformer =
        UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            return outgoing
        }
        configureSocialButton(
            facebookButtonView,
            imageName: "facebook-logo"
        )
        configureSocialButton(
            googleButtonView,
            imageName: "google-logo"
        )
        configureSocialButton(
            appleButtonView,
            imageName: "apple-logo"
        )
    }
    func setupCheckboxButton() {
        checkboxButtonView.setImage(UIImage(named: "checkbox"), for: .normal)
        checkboxButtonView.contentMode = .scaleAspectFit
        checkboxButtonView.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
    }
    
    private func updateCheckboxUI() {
        let imageName = isChecked ? "checkbox-group" : "checkbox"
        checkboxButtonView.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func setupActions() {
        signinButtonView.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

}

//MARK: - Actions
private extension LoginViewController {
    func applyEmailFocusedState() {
        emailTextFieldImageView.tintColor = .appRed
        emailView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.08)
        emailView.layer.borderColor = UIColor.red.cgColor
        emailView.layer.borderWidth = 1
    }
    
    func resetEmailState() {
        emailTextFieldImageView.tintColor = .lightGray
        emailView.layer.borderWidth = 0
        emailView.layer.borderColor = UIColor.clear.cgColor
        emailView.backgroundColor = UIColor(named: "textfied-color")
    }
    
    private func applyPasswordFocusedState() {
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        passwordTextFieldImageView.tintColor = .appRed
        passwordView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.08)
        passwordView.layer.borderColor = UIColor.red.cgColor
        passwordView.layer.borderWidth = 1
        hidePasswordImageView.tintColor = .appRed
    }
    
    private func resetPasswordState() {
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordView.layer.borderWidth = 0
        passwordView.layer.borderColor = UIColor.clear.cgColor
        passwordTextFieldImageView.tintColor = .lightGray
        passwordView.backgroundColor = UIColor(named: "textfied-color")
        hidePasswordImageView.tintColor = .lightGray
    }
    
    func makeViewFocusable(_ view: UIView, action: Selector) {
       view.isUserInteractionEnabled = true
       view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
   }
}
extension LoginViewController {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            applyEmailFocusedState()
        } else if textField == passwordTextField {
            applyPasswordFocusedState()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            resetEmailState()
        } else if textField == passwordTextField {
            resetPasswordState()
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

private extension LoginViewController {
    private func configureSocialButton(
        _ button: UIButton,
        imageName: String
    ) {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(named: imageName)
            config.imagePlacement = .leading
            config.imagePadding = 10
            config.baseBackgroundColor = .white
            config.baseForegroundColor = .black
            config.background.cornerRadius = 16
            config.background.strokeWidth = 0.5
            config.background.strokeColor = UIColor.black.withAlphaComponent(0.1)
            config.contentInsets = NSDirectionalEdgeInsets(
                top: 18,
                leading: 32,
                bottom: 18,
                trailing: 32
            )
            button.configuration = config
    }
}

private extension LoginViewController {
    func setupAttributedLabel() {
        signupLabel.isUserInteractionEnabled = true
        let attributedString = NSMutableAttributedString(string: Constants.signupLabel)
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: Constants.signupLabel.count))
        let signupRange = (Constants.signupLabel as NSString).range(of: "Sign up")
        attributedString.addAttributes([
            .foregroundColor: UIColor.red,
            .font: UIFont.boldSystemFont(ofSize: 15)
        ], range: signupRange)
        signupLabel.attributedText = attributedString
    }
}

private extension LoginViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

private extension LoginViewController {
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

private extension UINavigationController {
    func popToViewController<T: UIViewController>(ofType: T.Type, animated: Bool) {
        if let vc = viewControllers.first(where: { $0 is T }) {
            popToViewController(vc, animated: animated)
        }
    }
}

private extension LoginViewController {
    func navigateToHome() {
        AppRouter.showHome()
    }
}
