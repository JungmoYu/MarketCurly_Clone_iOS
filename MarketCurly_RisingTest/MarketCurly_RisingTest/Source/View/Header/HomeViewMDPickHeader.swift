//
//  HomeViewMDPickHeader.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/20.
//

import UIKit

class HomeViewMDPickHeader: UICollectionReusableView {
    // MARK: - Properties
    
    static let identifier: String = String(describing: HomeViewMDPickHeader.self)
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "MD의 추천"
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: - Actions
    
    @objc func viewAllBtnDidTap() {
        print("ItemListHeader - viewAllBtnDidTap() called")
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(headerTitleLabel)
        headerTitleLabel.centerY(inView: self)
        headerTitleLabel.anchor(left: leftAnchor, paddingLeft: 16)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureCell(isDailyPrice: Bool) {
    
    }
}

