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
    
    private let viewControllers = [HomeFirstViewController(),
                                   HomeSecondSubController(),
                                   HomeThirdSubController(),
                                   HomeFourthSubController(),
                                   HomeFifthSubController()]
    
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
        btn.addTarget(self, action: #selector(cartBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var locationBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "location"), for: .normal)
        return btn
    }()
    
    // MARK: - Action
    @objc func cartBtnDidTap() {
        if Constant.USER_INDEX < 0 {
            let controller = LoginViewController()
            controller.loginDelegate = self
            
            let nav = UINavigationController(rootViewController: controller)
            nav.navigationBar.isHidden = true
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } else {
            let controller = CartViewController()
            
            let nav = UINavigationController(rootViewController: controller)
            nav.navigationBar.isHidden = true
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCustomTab()
    }
    
    
    // MARK: - Helpers
    
    func configureNavigationBar() {
        let stack = UIStackView(arrangedSubviews: [locationBtn, cartBtn])
        stack.spacing = 10
            
        navigationItem.titleView = titleImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stack)
        
    }
    
    func configureCustomTab() {
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

extension HomeViewController: LoginViewControllerDelegate {
    func userLoggedIn() {
        let controller = CartViewController()
        
        let nav = UINavigationController(rootViewController: controller)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    
}
