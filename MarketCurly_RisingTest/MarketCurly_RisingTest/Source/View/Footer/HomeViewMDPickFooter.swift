//
//  HomeViewMDPickFooter.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/20.
//

import UIKit

class HomeViewMDPickFooter: UICollectionReusableView {
    // MARK: - Properties
    
    static let identifier: String = String(describing: HomeViewMDPickFooter.self)
    
    private lazy var viewAllBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .lightGray
        btn.setTitle("채소 전체보기 ›", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(viewAllBtnDidTap), for: .touchUpInside)
        return btn
    }()

    
    // MARK: - Action
    
    @objc func viewAllBtnDidTap() {
        print("HomeViewMDPickFooter - viewAllBtnDidTap() called")
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .white
        addSubview(viewAllBtn)
        viewAllBtn.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    
}
