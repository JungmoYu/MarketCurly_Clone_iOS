//
//  FruitViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/20.
//

import UIKit

class FruitViewController: BaseViewController{
    
    // MARK: - Properties
    
    let label: UILabel = {
        let l = UILabel()
        l.text = "과일 견과 쌀"
        return l
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        label.centerX(inView: view)
        label.centerY(inView: view)
    }
    
    // MARK: - Helpers
}
