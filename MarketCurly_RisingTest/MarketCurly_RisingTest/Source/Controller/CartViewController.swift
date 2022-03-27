//
//  CartViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/27.
//

import UIKit

class CartViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var isInItem: Bool = false
    private var cartList: [CartListResult] = []
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "장바구니"
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
    
    private let locationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "location")
        iv.tintColor = .black
        iv.setDimensions(height: 15, width: 15)
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.text = "›"
        label.textAlignment = .right
        label.setWidth(30)
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black.withAlphaComponent(0.5)
        return label
    }()
    
    private let shipLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "샛별배송"
        label.textColor = .mainPurple
        return label
    }()

    private let noItemLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "장바구니에 담긴 상품이 없습니다"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var buyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setHeight(50)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(buyBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Action
    
    @objc func buyBtnDidTap() {
        
    }
    
    @objc func cancelBtnDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartList = []
        ItemManagementManager().getCartList() { result in
            switch result {
            case .success(let data):
                if let result = data.result {
                    self.cartList += result
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(cancelBtn)
        cancelBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingLeft: 16)
        
        view.addSubview(loginLabel)
        loginLabel.centerX(inView: view)
        loginLabel.centerY(inView: cancelBtn)
        
        if cartList.count != 0 {
            configureUIWithItem()
        } else {
            configureUIWithNoItem()
        }
    }
    
    func configureUIWithItem() {
        
    }
    
    func configureUIWithNoItem() {
        
        view.addSubview(locationImageView)
        locationImageView.anchor(top: loginLabel.bottomAnchor, left: view.leftAnchor,
                                 paddingTop: 24, paddingLeft: 16)
        
        view.addSubview(rightLabel)
        rightLabel.centerY(inView: locationImageView)
        rightLabel.anchor(right: view.rightAnchor, paddingRight: 16)
        
        view.addSubview(addressLabel)
        addressLabel.text = Constant.User?.address
        addressLabel.centerY(inView: locationImageView)
        addressLabel.anchor(left: locationImageView.rightAnchor, right: rightLabel.leftAnchor, paddingLeft: 16)
        
        view.addSubview(shipLabel)
        shipLabel.anchor(top: addressLabel.bottomAnchor, left: addressLabel.leftAnchor, paddingTop: 5)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        divider.setHeight(10)
        
        view.addSubview(divider)
        divider.anchor(top: shipLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10)
        
        view.addSubview(noItemLabel)
        noItemLabel.centerY(inView: view)
        noItemLabel.centerX(inView: view)
        
        buyBtn.backgroundColor = .lightGray.withAlphaComponent(0.5)
        buyBtn.setTitle("상품을 담아주세요", for: .normal)
        buyBtn.isEnabled = false
        view.addSubview(buyBtn)
        buyBtn.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                      paddingLeft: 16, paddingRight: 16)
    }
}
