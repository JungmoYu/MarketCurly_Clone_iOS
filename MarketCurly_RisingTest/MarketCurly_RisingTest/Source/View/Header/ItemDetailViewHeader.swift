//
//  ItemDetailViewHeader.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/22.
//

import UIKit

class ItemDetailViewHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: ItemDetailViewHeader.self)
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let memberPriceTextLabel: UILabel = {
        let label = UILabel()
        label.text = "회원할인가"
        label.textColor = .black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let memberPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let discountRateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .mainOrange
        return label
    }()
    
    private let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let pointLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .mainPurple
        return label
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(productImageView)
        productImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        productImageView.setHeight(550)
        
        addSubview(nameLabel)
        nameLabel.anchor(top: productImageView.bottomAnchor, left: leftAnchor,
                         paddingTop: 20, paddingLeft: 16)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, left: leftAnchor,
                                paddingTop: 5, paddingLeft: 16)
        
        addSubview(memberPriceTextLabel)
        memberPriceTextLabel.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor,
                                    paddingTop: 16, paddingLeft: 16)
        
        let stack = UIStackView(arrangedSubviews: [memberPriceLabel, discountRateLabel])
        stack.spacing = 10
        stack.distribution = .fillProportionally
        
        addSubview(stack)
        stack.anchor(top: memberPriceTextLabel.bottomAnchor, left: leftAnchor,
                     paddingTop: 5, paddingLeft: 16)
        
        addSubview(originalPriceLabel)
        originalPriceLabel.anchor(top: stack.bottomAnchor, left: leftAnchor,
                                  paddingTop: 5, paddingLeft: 16)
        
        addSubview(pointLabel)
        pointLabel.anchor(top: originalPriceLabel.bottomAnchor, left: leftAnchor,
                          paddingTop: 10, paddingLeft: 16)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        
        addSubview(divider)
        divider.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                       paddingTop: 16)
        divider.setHeight(8)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureAdImage(for imgString: String) {
        productImageView.image = UIImage(named: imgString) //상품예시
    }
    
    func configureNameLabel(_ text: String) {
        nameLabel.text = text
    }
    
    func configureDescriptionLabel(_ text: String) {
        descriptionLabel.text = text
    }
    
    func configureMemberPriceLabel(_ text: String) {
        memberPriceLabel.text = text
    }
    
    func configureDiscountRateLabel(_ text: String) {
        discountRateLabel.text = text
    }
    
    func configureOriginalPriceLabel(_ text: String) {
        originalPriceLabel.attributedText = text.strikeThrough()
    }
    
    func configurePointLabel(_ text: String, isMember: Bool) {
        if isMember {
            pointLabel.text = text
        } else {
            pointLabel.text = "로그인 후, 회원할인가와 적립혜택이 제공됩니다."
        }
    }
}
