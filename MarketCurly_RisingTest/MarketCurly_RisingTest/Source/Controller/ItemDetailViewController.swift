//
//  ItemDetailViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/22.
//

import UIKit
import Tabman
import Pageboy

class ItemDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    var itemInfo: ItemInfoResult?
//    private var itemInfoDetail: [ItemInfoDetailResult] = []
    
    private let firstController = ItemFirstSubController()
    private let secondController = ItemSecondSubController()
    private let thirdController = ItemThirdSubController()
    private let fourthController = ItemFourthSubController()
    
    private lazy var viewControllers = [self.firstController,
                                        self.secondController,
                                        self.thirdController,
                                        self.fourthController]
    
    
    private let titleArray: [String] = ["상품설명", "상세정보", "후기", "문의"]
    
    private lazy var cartBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "cart"), for: .normal)
        btn.addTarget(self, action: #selector(cartBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Action
    
    @objc func cartBtnDidTap() {
        if Constant.USER_INDEX < 0 {
            let controller = LoginViewController()
//            controller.loginDelegate = self
            
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
        firstController.itemInfo = itemInfo
        secondController.itemInfo = itemInfo
        thirdController.itemInfo = itemInfo
        fourthController.itemInfo = itemInfo
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        itemInfoDetail = []
//
//        ItemManagementManager().getItemDetail(itemNum: 1) { result in
//            switch result {
//            case .success(let data):
//                data.result?.forEach {
//                    self.itemInfoDetail.append($0)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            IndicatorView.shared.dismiss()
//        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Helpers
    
    func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartBtn)
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

extension ItemDetailViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
