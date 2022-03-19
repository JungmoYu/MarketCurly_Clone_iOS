//
//  ProfileViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let titleImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo_white")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var cartBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "cart"), for: .normal)
        return btn
    }()
    
    private lazy var locationBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "location"), for: .normal)
        return btn
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    // MARK: - Helpers
    
    func configureNavigationBar() {
        
        let stack = UIStackView(arrangedSubviews: [locationBtn, cartBtn])
        stack.spacing = 10
            
        navigationItem.title = "마이컬리"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stack)
        
    }
}
