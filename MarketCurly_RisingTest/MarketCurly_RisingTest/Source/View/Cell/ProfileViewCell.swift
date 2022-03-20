//
//  ProfileViewCell.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/20.
//

import UIKit


class ProfileViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: ProfileViewCell.self)
    
    private let labelImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "gearshape")
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .lightGray
        iv.setDimensions(height: 30, width: 30)
        return iv
    }()
    
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.text = "설정" //지워야함
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let enterLabel: UILabel = {
        let label = UILabel()
        label.text = "›"
        label.textColor = .lightGray.withAlphaComponent(0.3)
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(menuLabel)
        menuLabel.centerY(inView: self)
        menuLabel.anchor(left: leftAnchor, paddingLeft: 16)
        
        addSubview(enterLabel)
        enterLabel.centerY(inView: self)
        enterLabel.anchor(right: rightAnchor, paddingRight: 16)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        divider.setHeight(0.5)
        
        addSubview(divider)
        divider.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    func configureMenuLabelText(withText text: String) {
        menuLabel.text = text
    }
    
    
}

