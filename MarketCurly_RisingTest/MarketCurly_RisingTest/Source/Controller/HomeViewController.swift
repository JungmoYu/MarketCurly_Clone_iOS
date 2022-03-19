//
//  HomeViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit
import Tabman
import Pageboy

class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewControllers = [BaseViewController(), BaseViewController(), BaseViewController(), BaseViewController(), BaseViewController()]
    private let titleArray: [String] = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "특가/혜택"]
    
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
            
        
        navigationItem.titleView = titleImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stack)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .flat(color: .white)
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        bar.indicator.tintColor = .mainPurple
        bar.buttons.customize { button in
            button.tintColor = .lightGray
            button.selectedTintColor = .mainPurple
            button.font = .systemFont(ofSize: 14)
            button.selectedFont = .boldSystemFont(ofSize: 14)
        }
        
        addBar(bar, dataSource: self, at: .top)
        
        
    }
}


extension HomeViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: titleArray[index])
    }
    
    
}
