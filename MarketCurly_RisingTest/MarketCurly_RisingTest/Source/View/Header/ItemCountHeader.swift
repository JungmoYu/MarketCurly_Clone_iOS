//
//  ItemCountHeader.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class ItemCountHeader: UICollectionReusableView {
    // MARK: - Properties
    
    static let identifier: String = String(describing: ItemCountHeader.self)
    
    private let numOfItemLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "총 300개"
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var sortBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("추천순∨", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(sortBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Actions
    
    @objc func sortBtnDidTap() {
        print("ItemCountHeader - sortBtnDidTap() called")
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(sortBtn)
        sortBtn.centerY(inView: self)
        sortBtn.anchor(right: rightAnchor)
        
        addSubview(numOfItemLabel)
        numOfItemLabel.centerY(inView: sortBtn)
        numOfItemLabel.anchor(left: leftAnchor)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUIForSearchController() {
        numOfItemLabel.text = "추천검색어"
        numOfItemLabel.font = .boldSystemFont(ofSize: 20)
        numOfItemLabel.centerY(inView: self)
        sortBtn.removeFromSuperview()
    }
}
