//
//  UIButton.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

// MARK: UIButton 내에 Indicator 표시
extension UIButton {
    func showIndicator() {
        let indicator = UIActivityIndicatorView()
        let buttonHeight = self.bounds.size.height
        let buttonWidth = self.bounds.size.width
        indicator.center = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)
        self.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func dismissIndicator() {
        for view in self.subviews {
            if let indicator = view as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
    
    func attributedTitle(firstPart: String, secondPart: String) {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black.cgColor, .font: UIFont.systemFont(ofSize: 8)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart)\n", attributes: atts)

        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black.cgColor, .font: UIFont.boldSystemFont(ofSize: 18)]
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))

        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    
}


class CustomCheckButton: UIButton {
    
    enum ButtonState {
        case normal
        case isSelected
    }
    
    private var disabledBackgroundColor: UIColor?
    private var defaultBackgroundColor: UIColor? {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                if let color = disabledBackgroundColor {
                    self.backgroundColor = color
                }
            }
            else {
                if let color = defaultBackgroundColor {
                    self.backgroundColor = color
                }
            }
        }
    }
    
    // 5. our custom functions to set color for different state
    func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
        switch state {
        case .isSelected:
            disabledBackgroundColor = color
        case .normal:
            defaultBackgroundColor = color
        }
    }
}


extension UIButton {
    func changeColor() {
        if tintColor == .mainPurple {
            tintColor = .lightGray.withAlphaComponent(0.5)
        } else {
            tintColor = .mainPurple
        }
    }
    
    func isSelectedBtn() -> Bool {
        if tintColor == .mainPurple {
            return true
        } else {
            return false
        }
    }
    
    func setSelectedBtn(_ isSelected: Bool) {
        if isSelected {
            tintColor = .mainPurple
        }
    }
    
    func changeBackgroundColor(_ isSelected: Bool) {
        switch tag {
        case 1:
            if isSelected {
                backgroundColor = .systemYellow
            } else {
                backgroundColor = .clear
            }
        default:
            if isSelected {
                backgroundColor = .mainPurple
                setTitleColor(.white, for: .normal)
            } else {
                backgroundColor = .clear
                setTitleColor(.black, for: .normal)
            }
        }
        
    }
}
