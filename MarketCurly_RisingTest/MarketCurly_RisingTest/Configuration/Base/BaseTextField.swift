//
//  BaseTextField.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/20.
//

import UIKit

class BaseTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    
        textColor = .lightGray
        tintColor = .black
        
//        keyboardAppearance = .dark
        keyboardAppearance = .default
        
        autocapitalizationType = .none
        backgroundColor = UIColor(white: 1, alpha: 0.1)
//        backgroundColor = .lightGray.withAlphaComponent(0.15)
        setHeight(50)
//        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5),
                                                                                     .font: UIFont.systemFont(ofSize: 14)])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
