//
//  BuyTableViewCell.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/27.
//

import UIKit

protocol BuyTableViewCellDelegate: AnyObject {
    func minusBtnDidTap(rowAt: Int)
    func plusBtnDidTap(rowAt: Int)
}

class BuyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: BuyTableViewCell.self)
    var numOfItem = 0
    var numOfRow = 0
    weak var delegate: BuyTableViewCellDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let memberPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var minusBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "minus"), for: .normal)
        btn.setDimensions(height: 20, width: 20)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(minusBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var plusBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.setDimensions(height: 20, width: 20)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(plusBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private let numOfItemLabel: UILabel = {
        let label = UILabel()
        label.setDimensions(height: 20, width: 20)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Action
    
    @objc func minusBtnDidTap() {
        delegate?.minusBtnDidTap(rowAt: numOfRow)
    }
    
    @objc func plusBtnDidTap() {
        delegate?.plusBtnDidTap(rowAt: numOfRow)
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helpers
    
    func configureUI(title: String, originalPrice: Int, off: Int) {
        addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        
        let numOfItemStack = UIStackView(arrangedSubviews: [minusBtn, numOfItemLabel, plusBtn])
        numOfItemLabel.text = String(numOfItem)
        numOfItemStack.spacing = 5
        numOfItemStack.layer.borderColor = UIColor.lightGray.cgColor
        numOfItemStack.layer.borderWidth = 0.5
        numOfItemStack.layer.cornerRadius = 2
        numOfItemStack.isLayoutMarginsRelativeArrangement = true
        numOfItemStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        contentView.addSubview(numOfItemStack)
        numOfItemStack.anchor(bottom: bottomAnchor, right: rightAnchor, paddingBottom: 12, paddingRight: 16)
        
        addSubview(memberPriceLabel)
        memberPriceLabel.anchor(left: leftAnchor, bottom: numOfItemStack.bottomAnchor, paddingLeft: 16)
        memberPriceLabel.text = String(Int(Double(originalPrice) * Double(Double(100 - off) * 0.01))).insertComma + "원"
        
        if off != 0 {
            addSubview(originalPriceLabel)
            originalPriceLabel.anchor(left: memberPriceLabel.rightAnchor, bottom: numOfItemStack.bottomAnchor, paddingLeft: 5)
            originalPriceLabel.attributedText = (String(originalPrice) + "원").strikeThrough()
        }
        
        let divider = UIView()
        divider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        divider.setHeight(0.5)
        
        addSubview(divider)
        divider.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
        
    }
}
