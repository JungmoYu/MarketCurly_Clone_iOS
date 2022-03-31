//
//  ItemFourthSubController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/22.
//

import UIKit

class ItemFourthSubController: BaseViewController {
    
    // MARK: - Properties
    
    var itemInfo: ItemInfoResult?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "리뷰예시")
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private lazy var createReviewBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        btn.setTitle("상품 문의하기", for: .normal)
        btn.setTitleColor(.mainPurple, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        btn.layer.borderColor = UIColor.mainPurple.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(createReviewBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private let likeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.setDimensions(height: 50, width: 50)
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        btn.layer.borderWidth = 0.5
        btn.tintColor = .systemRed
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(likeBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private let buyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .mainPurple
        btn.setTitle("구매하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(buyBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Action
    
    @objc func createReviewBtnDidTap() {
        if Constant.User == nil {
            self.presentAlert(title: "로그인 후 이용할 수 있습니다")
        }
        else {
            self.presentAlert(title: "해당 기능은 구현되지 않았습니다")
        }
    }
    
    @objc func buyBtnDidTap() {
        self.presentAlert(title: "문의탭이 아닌 다른 탭에서 구매해주세요")
    }
    
    @objc func likeBtnDidTap() {
        print("ItemFourthSubController - likeBtnDidTap() called")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(createReviewBtn)
        createReviewBtn.setHeight(50)
        createReviewBtn.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                               paddingTop: 66, paddingLeft: 16, paddingRight: 16)
        
        let bottomStack = UIStackView(arrangedSubviews: [likeBtn, buyBtn])
        bottomStack.spacing = 10
        bottomStack.distribution = .fill
        
        view.addSubview(bottomStack)
        bottomStack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                           paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(imageView)
        imageView.anchor(top: createReviewBtn.bottomAnchor, left: view.leftAnchor,
                              bottom: bottomStack.topAnchor, right: view.rightAnchor, paddingTop: 16)
    }
    
    
}

