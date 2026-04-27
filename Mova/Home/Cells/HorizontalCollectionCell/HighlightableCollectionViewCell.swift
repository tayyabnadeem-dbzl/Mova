//
//  HighlightableCollectionViewCell.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 24/04/2026.
//

import Foundation
import UIKit


public enum HighlightInteraction {
    case select
    case touch
}

open class HighlightableCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    open var highlightScaleX: CGFloat = 0.95
    open var highlightScaleY: CGFloat = 0.95
    open var highlightAlpha: CGFloat = 0.5
    open var highlightAnimation: HighlightAnimation = .fade
    open var highlightAnimationDuration: TimeInterval = 0.2

    open var highlightInteraction: HighlightInteraction = .touch {
        didSet { setupHighlightInteraction() }
    }

    private var tapGesture: UILongPressGestureRecognizer?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHighlightInteraction()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHighlightInteraction()
    }

    // MARK: - Reuse safety
    open override func prepareForReuse() {
        super.prepareForReuse()
        contentView.alpha = 1
        contentView.transform = .identity
    }

    // MARK: - Selection-based highlight
    open override var isHighlighted: Bool {
        didSet {
            guard highlightInteraction == .select else { return }
            isHighlighted ? highlight() : unhighlight()
        }
    }

    // MARK: - Public animation
    open func highlight() {
        guard highlightAnimation != .none else { return }

        UIView.animate(withDuration: highlightAnimationDuration) { [weak self] in
            guard let self else { return }

            switch self.highlightAnimation {
            case .fade:
                self.contentView.alpha = self.highlightAlpha

            case .scale:
                self.contentView.transform = CGAffineTransform(
                    scaleX: self.highlightScaleX,
                    y: self.highlightScaleY
                )

            case .none:
                break
            }
        }
    }

    open func unhighlight() {
        guard highlightAnimation != .none else { return }

        UIView.animate(withDuration: highlightAnimationDuration) { [weak self] in
            self?.contentView.alpha = 1
            self?.contentView.transform = .identity
        }
    }
}

private extension HighlightableCollectionViewCell {

    func setupHighlightInteraction() {
        switch highlightInteraction {

        case .select:
            removeGesture()

        case .touch:
            addGesture()
        }
    }

    func addGesture() {
        removeGesture()

        let gesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleTouch)
        )

        gesture.minimumPressDuration = 0
        gesture.cancelsTouchesInView = false
        gesture.delegate = self

        contentView.addGestureRecognizer(gesture)
        tapGesture = gesture
    }

    func removeGesture() {
        if let gesture = tapGesture {
            contentView.removeGestureRecognizer(gesture)
        }
        tapGesture = nil
    }

    @objc
    func handleTouch(gesture: UILongPressGestureRecognizer) {
        guard highlightInteraction == .touch else { return }

        switch gesture.state {
        case .began:
            highlight()
        case .ended, .cancelled, .failed:
            unhighlight()
        default:
            break
        }
    }
}
extension HighlightableCollectionViewCell: UIGestureRecognizerDelegate {

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton {
            return false
        }
        return gestureRecognizer.view == contentView
    }
}
