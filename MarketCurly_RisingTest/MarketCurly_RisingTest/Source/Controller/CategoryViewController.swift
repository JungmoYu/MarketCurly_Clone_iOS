//
//  CategoryViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit
import Lottie

class CategoryViewController: BaseViewController {
    
    // MARK: - Properties
    
    
    
    private var tableViewData: [CellData] = [ CellData(opend: false, title: "🥬 채소", sectionData: ["        친환경",
                                                                                                "        고구마﹒감자﹒당근",
                                                                                                "        시금치﹒쌈채소﹒나물",
                                                                                                "        브로콜리﹒파프리카﹒양배추"]),
                                              CellData(opend: false, title: "🍎 과일﹒견과﹒쌀", sectionData: ["        친환경",
                                                                                              "        제철과일",
                                                                                              "        국산과일",
                                                                                              "        수입과일"]),
                                              CellData(opend: false, title: "🐟 수산﹒해산﹒건어물", sectionData: ["        제철수산",
                                                                                              "        생선류",
                                                                                              "        굴비류﹒반건류",
                                                                                              "        오징어﹒낙지﹒문어"]),
                                              CellData(opend: false, title: "🍖 정육﹒계란", sectionData: ["        국내산 소고기",
                                                                                              "        수입산 소고기",
                                                                                              "        돼지고기",
                                                                                              "        계란류"]),
                                              CellData(opend: false, title: "🍚 국﹒반찬﹒메인요리", sectionData: ["        국﹒탕﹒찌개",
                                                                                              "        밀키트﹒메인요리",
                                                                                              "        밑반찬",
                                                                                              "        김치﹒젓갈﹒장류"])]
    
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
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opend {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier,
                                                     for: indexPath) as! CategoryTableViewCell
        
            cell.titleLabel.text = tableViewData[indexPath.section].title
            cell.backgroundColor = .white
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier,
                                                     for: indexPath) as! CategoryTableViewCell
            cell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            cell.backgroundColor = .lightGray.withAlphaComponent(0.15)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var controller = UIViewController()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            tableViewData[indexPath.section].opend.toggle()
            tableView.reloadSections([indexPath.section], with: .fade)
        } else {
            switch indexPath.section {
            case 0:
                controller = VegetableViewController()
            case 1:
                controller = FruitViewController()
            case 2:
                controller = SeaFoodViewController()
            case 3:
                controller = MeatViewController()
            case 4:
                controller = SoupViewController()
            default:
                return
            }
            navigationController?.pushViewController(controller, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
    }
    
    
}



