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
    
    private let firstController = ItemFirstSubController()
    
    private lazy var viewControllers = [self.firstController,
                                   ItemSecondSubController(),
                                   ItemThirdSubController(),
                                   ItemFourthSubController()]
    
    
    var itemInfo: String = "" // 여기 이전 뷰컨트롤러에서 전달받아서 아이템 모델 객체로 만들어야함
    
    private let titleArray: [String] = ["상품설명", "상세정보", "후기", "문의"]
    
    private lazy var cartBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "cart"), for: .normal)
        return btn
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCustomTab()
        firstController.itemInfo = itemInfo
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
