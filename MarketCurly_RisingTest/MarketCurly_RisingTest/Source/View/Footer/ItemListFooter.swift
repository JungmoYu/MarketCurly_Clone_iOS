//
//  ItemListFooter.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class ItemListFooter: UICollectionReusableView {
    // MARK: - Properties
    
    static let identifier: String = String(describing: ItemListFooter.self)
    
    private let adImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .white
        addSubview(adImageView)
        adImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureAdImage(item imgString: String) {
        adImageView.image = UIImage(named: imgString)
    }
}
