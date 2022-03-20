//
//  HomeViewMDPickCell.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/20.
//

import UIKit
import Tabman
import Pageboy

class HomeViewMDPickCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: HomeViewMDPickCell.self)
    
    private let viewControllers = [VegetableViewController(),
                                   FruitViewController(),
                                   SeaFoodViewController(),
                                   MeatViewController(),
                                   SoupViewController()]
    
    private let titleArray: [String] = ["채소", "과일﹒견과﹒쌀", "수산﹒해산﹒건어물", "정육﹒계란", "국﹒반찬﹒메인요리"]
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

    
}

