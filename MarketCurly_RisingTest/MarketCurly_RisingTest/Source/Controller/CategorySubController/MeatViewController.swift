//
//  MeatViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/20.
//

import UIKit

class MeatViewController: BaseViewController{
    
    // MARK: - Properties
    
    let label: UILabel = {
        let l = UILabel()
        l.text = "정육 계란"
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
