//
//  HighlightingTableViewCell.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 24/04/2026.
//

import UIKit

public enum HighlightAnimation {
    case fade
    case scale
    case none
}

open class HighlightableTableViewCell: UITableViewCell {

    // MARK: - Properties
    public var highlightScaleX: CGFloat = 0.95
    public var highlightScaleY: CGFloat = 0.95
    public var highlightAlpha: CGFloat = 0.5
    public var highlightAnimation: HighlightAnimation = .scale
    public var highlightAnimationDuration: TimeInterval = 0.2
    private var tapGesture: UILongPressGestureRecognizer!
    public var highlightAction: (() -> Void)?
    public var unhighlightAction: (() -> Void)?

    // MARK: - Init
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    private func commonInit() {
        setupGestureRecognizer()
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        contentView.alpha = 1
        contentView.transform = .identity
    }

    // MARK: - Gesture setup
    private func setupGestureRecognizer() {
        tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTouch))
        tapGesture.minimumPressDuration = 0
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        contentView.addGestureRecognizer(tapGesture)
    }

    @objc
    private func handleTouch(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            highlight()
        case .ended, .cancelled, .failed:
            unhighlight()
        default:
            break
        }
    }

    // MARK: - Highlight logic
    open func highlight() {
        guard highlightAnimation != .none else { return }
        highlightAction?()
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

        unhighlightAction?()

        UIView.animate(withDuration: highlightAnimationDuration) { [weak self] in
            self?.contentView.alpha = 1
            self?.contentView.transform = .identity
        }
    }
}
extension HighlightableTableViewCell {
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }

    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton {
            return false
        }
        return true
    }
}
