//
//  SignupViewModel.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 09/04/2026.
//

import Foundation
import UIKit
protocol OptionsSignupViewModelType {
    var onBack : (() -> Void)? {get set}
    var onSignup: (() -> Void)? {get set}
    var onLogin: (() -> Void)? {get set}
    
    func didTapBack()
    func didTapSignup()
    func didTapLogin()
}

final class OptionsSignupViewModel : OptionsSignupViewModelType {

    //MARK: - Properties
    var onSignup: (() -> Void)?
    var onBack: (() -> Void)?
    var onLogin: (() -> Void)?
    
    func didTapBack() {
        onBack?()
    }
    
    func didTapSignup() {
        onSignup?()
    }
    
    func didTapLogin() {
        onLogin?()
    }
    
    private func didTapAttributedText(in label: UILabel, gesture: UITapGestureRecognizer, targetText: String) -> Bool {
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
