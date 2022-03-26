//
//  ItemInfoCell.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class ItemInfoCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: ItemInfoCell.self)
    
    private let itemImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "상품예시")
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private let vendorLabel: UILabel = {
        let label = UILabel()
        label.text = "[상품 이름]" // 상품이름 데이터 받아와서 처리
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "상품 이름" // 상품이름 데이터 받아와서 처리
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let memberPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "3000".insertComma
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let discountRateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .mainOrange
        label.text = "20%"
        return label
    }()
    
    private let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.attributedText = "4000".strikeThrough()
        return label
    }()
    
    private let dailyPriceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .mainPurple.withAlphaComponent(0.8)
        label.text = "일일특가"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var cartBtn: RoundButton = {
        let btn = RoundButton(type: .system)
        btn.setImage(UIImage(systemName: "cart"), for: .normal)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.backgroundColor = .mainPurple.withAlphaComponent(0.5)
        btn.addTarget(self, action: #selector(cartBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Actions
    
    @objc func cartBtnDidTap() {
        print("ItemCell - cartBtnDidTap() called")
    }
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(itemImageView)
        itemImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        itemImageView.setHeightEqualToSuperViewMuliplyBy(0.7)
        
        addSubview(cartBtn)
        cartBtn.anchor(bottom: itemImageView.bottomAnchor, right: itemImageView.rightAnchor,
                             paddingBottom: 10, paddingRight: 10)
        cartBtn.setHeightEqualToSuperViewMuliplyBy(0.12)
        cartBtn.setWidthEqualToHeightMuliplyBy(1)
        
        let titleStack = UIStackView(arrangedSubviews: [vendorLabel, titleLabel])
        titleStack.spacing = 3
        
        addSubview(titleStack)
        titleStack.anchor(top: itemImageView.bottomAnchor, left: leftAnchor, paddingTop: 5)
        
        let priceStack = UIStackView(arrangedSubviews: [discountRateLabel, memberPriceLabel])
        priceStack.spacing = 3
        
        addSubview(priceStack)
        priceStack.anchor(top: titleStack.bottomAnchor, left: leftAnchor, paddingTop: 5)
        
        addSubview(originalPriceLabel)
        originalPriceLabel.anchor(top: priceStack.bottomAnchor, left: leftAnchor)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureCell(_ item: ItemInfoResult ,isDailyPrice: Bool) {
        if isDailyPrice {
            self.addSubview(dailyPriceLabel)
            dailyPriceLabel.setWidthEqualToSuperViewMuliplyBy(0.15)
            dailyPriceLabel.setHeightEqualToSuperViewMuliplyBy(0.1)
            dailyPriceLabel.anchor(top: self.topAnchor, left: self.leftAnchor)
            
        } else {
            
        }
        
        setLabelText(item)
    }
    
    func setLabelText(_ item: ItemInfoResult) {
        vendorLabel.text = item.vendor
        titleLabel.text = item.title
        discountRateLabel.text = item.off + "%"
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func getTitle() -> String {
        return titleLabel.text ?? "이름 없는 상품"
    }
    
}
