//
//  BuyViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/27.
//

import UIKit

class BuyViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var itemInfoDetail: [ItemInfoDetailResult] = []
    private var numOfItem: [Int] = []
    var itemID: Int = 1
    var off: Int = 0
    var totalNumOfItem: Int = 0
    var totalPrice = 0
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "상품 선택"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("𝖷", for: .normal)
        btn.tintColor = .black
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(cancelBtnDidTap), for: .touchUpInside)
        return btn
    }()

    private lazy var insertItemsToCartBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setHeight(50)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("장바구니담기", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.backgroundColor = .mainPurple
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(insertItemsToCartBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Action
    
    @objc func insertItemsToCartBtnDidTap() {

        if totalNumOfItem == 0 {
            self.presentAlert(title: "수량은 반드시 1이상이어야 합니다.")
            return
        }
        if Constant.User == nil {
            self.presentAlert(title: "장바구니 기능은 로그인시에 가능합니다.")
        } else {
            ItemManagementManager().addToCart(id: String(itemID), quantity: String(3)) { result in //String(itemID)
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                IndicatorView.shared.dismiss()
            }
        }
    }
    
    @objc func cancelBtnDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureTableView()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        itemInfoDetail = []
        ItemManagementManager().getItemDetail(itemNum: itemID) { result in
            
            switch result {
            case .success(let data):
                
                data.result?.forEach {
                    self.itemInfoDetail.append($0)
                    self.numOfItem.append(0)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.tableView.reloadData()
            IndicatorView.shared.dismiss()
        }
     
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(cancelBtn)
        cancelBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,paddingTop: 10, paddingLeft: 16)
        
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.centerY(inView: cancelBtn)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.setHeight(0.5)
        view.addSubview(divider)
        divider.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10)
        
        
        view.addSubview(insertItemsToCartBtn)
        insertItemsToCartBtn.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                    right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(tableView)
        tableView.anchor(top: divider.bottomAnchor, left: view.leftAnchor, bottom: insertItemsToCartBtn.topAnchor, right: view.rightAnchor)
        
        
        
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.register(BuyTableViewCell.self, forCellReuseIdentifier: BuyTableViewCell.identifier)
    }
    
    func changeBtnTitle() -> String {
        var str: String = ""
        totalPrice = 0
        totalNumOfItem = numOfItem.reduce(0) { $0 + $1 }
        if totalNumOfItem == 0 {
            str = "장바구니담기"
        } else {
            for (index, _) in numOfItem.enumerated() {
                totalPrice += numOfItem[index] * Int(Double(itemInfoDetail[index].price) * Double(Double(100 - off ) * 0.01))
            }
            str = String(totalPrice).insertComma + "원 장바구니 담기"
        }
        return str
    }
   
}


extension BuyViewController: UITableViewDelegate {
    
}

extension BuyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemInfoDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BuyTableViewCell.identifier, for: indexPath) as! BuyTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.numOfRow = indexPath.row
        cell.numOfItem = numOfItem[indexPath.row]
        cell.configureUI(title: itemInfoDetail[indexPath.row].name,
                         originalPrice: itemInfoDetail[indexPath.row].price,
                         off: off)
        return cell
    }

}

extension BuyViewController: BuyTableViewCellDelegate {
    func minusBtnDidTap(rowAt: Int) {
        if numOfItem[rowAt] > 0 {
            numOfItem[rowAt] -= 1
        }
        insertItemsToCartBtn.setTitle(changeBtnTitle(), for: .normal)
        tableView.reloadRows(at: [IndexPath(row: rowAt, section: 0)], with: .none)
    }
    
    func plusBtnDidTap(rowAt: Int) {
        numOfItem[rowAt] += 1
        insertItemsToCartBtn.setTitle(changeBtnTitle(), for: .normal)
        tableView.reloadRows(at: [IndexPath(row: rowAt, section: 0)], with: .none)
    }
    

}
