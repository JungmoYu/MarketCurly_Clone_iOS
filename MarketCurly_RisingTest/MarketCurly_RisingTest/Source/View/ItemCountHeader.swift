//
//  ItemListHeader.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class ItemListHeader: UICollectionReusableView {
    // MARK: - Properties
    
    static let identifier: String = String(describing: ItemListHeader.self)
    
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
        print("ItemListHeader - sortBtnDidTap() called")
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(sortBtn)
        sortBtn.anchor(top: topAnchor, right: rightAnchor)
        
        addSubview(numOfItemLabel)
        numOfItemLabel.centerY(inView: sortBtn)
        numOfItemLabel.anchor(left: leftAnchor)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
    }
}
