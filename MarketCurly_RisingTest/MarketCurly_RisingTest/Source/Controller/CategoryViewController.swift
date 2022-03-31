//
//  CategoryViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class CategoryViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var preSection: Int?

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        return tv
    }()
    
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
        btn.addTarget(self, action: #selector(locationBtnDidTap), for: .touchUpInside)
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
    
    @objc func locationBtnDidTap() {
        self.presentAlert(title: "사용자 정보에서 배송지를 변경해주세요")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
    
    func configureUI() {
        configureNavigationBar()
        
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    func configureNavigationBar() {
        
        let stack = UIStackView(arrangedSubviews: [locationBtn, cartBtn])
        stack.spacing = 10
            
        navigationItem.title = "카테고리"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stack)
    }
}

extension CategoryViewController: UITableViewDelegate {
    
}

extension CategoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constant.CATEGORY_DATA.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Constant.CATEGORY_DATA[section].opend {
            return Constant.CATEGORY_DATA[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier,
                                                     for: indexPath) as! CategoryTableViewCell
        
            cell.titleLabel.text = Constant.CATEGORY_DATA[indexPath.section].title
            cell.backgroundColor = .white
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier,
                                                     for: indexPath) as! CategoryTableViewCell
            cell.titleLabel.text = Constant.CATEGORY_DATA[indexPath.section].sectionData[indexPath.row - 1]
            cell.backgroundColor = .lightGray.withAlphaComponent(0.15)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            controlCategoris(indexPath: indexPath)
        } else {
            presentCategorySubController(indexPath: indexPath)
        }
    }
    
    func controlCategoris(indexPath: IndexPath) {
        if let preSection = preSection {
            if indexPath.section == preSection {
                Constant.CATEGORY_DATA[preSection].opend.toggle()
                tableView.reloadSections([preSection], with: .automatic)
                self.preSection = nil
                return
            } else {
                Constant.CATEGORY_DATA[preSection].opend.toggle()
                tableView.reloadSections([preSection], with: .automatic)
                Constant.CATEGORY_DATA[indexPath.section].opend.toggle()
                tableView.reloadSections([indexPath.section], with: .automatic)
                self.preSection = indexPath.section
                return
            }
        }
        Constant.CATEGORY_DATA[indexPath.section].opend.toggle()
        tableView.reloadSections([indexPath.section], with: .automatic)
        preSection = indexPath.section
    }
    
    func presentCategorySubController(indexPath: IndexPath) {
        var controller = UIViewController()
        switch Constant.CATEGORY_DATA[indexPath.section].title {
        case Constant.CATEGORY_DATA[0].title:
            controller = VegetableViewController()
        case Constant.CATEGORY_DATA[1].title:
            controller = FruitViewController()
        case Constant.CATEGORY_DATA[2].title:
            controller = SeaFoodViewController()
        case Constant.CATEGORY_DATA[3].title:
            controller = MeatViewController()
        case Constant.CATEGORY_DATA[4].title:
            controller = SoupViewController()
        default:
            return
        }
        navigationController?.pushViewController(controller, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    
}



extension CategoryViewController: LoginViewControllerDelegate {
    func userLoggedIn() {
        
    }
    
}
