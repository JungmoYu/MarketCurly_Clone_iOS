//
//  MainTabController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit


class MainTabController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        
        let home = templateNavigationController(image: UIImage(systemName: "house")!,
                                                withText: "홈", rootViewController: HomeViewController())
        
        
        let category = templateNavigationController(image: UIImage(systemName: "list.bullet")!,
                                                    withText: "카테고리", rootViewController: CategoryViewController())
        
        let search = templateNavigationController(image: UIImage(systemName: "magnifyingglass")!,
                                                    withText: "검색", rootViewController: SearchViewController())
        
        let profile = templateNavigationController(image: UIImage(systemName: "person")!,
                                                    withText: "마이컬리", rootViewController: ProfileViewController())
        
        viewControllers = [home, category, search, profile]
        
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.clipsToBounds = true
    }
    
    func templateNavigationController(image: UIImage, withText: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = withText
        nav.navigationBar.tintColor = .white
        
        return nav
    }
}
