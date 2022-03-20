//
//  ProfileViewHeader.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/20.
//

import UIKit


protocol ProfileViewHeaderDelegate: AnyObject {
    func popupLoginViewController()
}


class ProfileViewHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: ProfileViewHeader.self)
    
    weak var delegate: ProfileViewHeaderDelegate?
    
    private let welcomeTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainPurple
        label.layer.borderColor = UIColor.mainPurple.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 3
        return label
    }()
    
    private let pointPercentageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var showRewardBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("가입 혜택 보기 ›", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(showRewardBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var loginOrJoinBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .mainPurple
        btn.layer.cornerRadius = 3
        btn.setTitle("로그인/회원가입", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(loginOrJoinBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var showAllGradeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .lightGray.withAlphaComponent(0.15)
        btn.setTitle("전체등급 보기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(showAllGradeBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var showNextMonthGradeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .lightGray.withAlphaComponent(0.15)
        btn.setTitle("다음 달 예상등급 보기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(showNextMonthGradeBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Actions
    
    @objc func showRewardBtnDidTap() {
        print("ProfileViewHeader = showRewardBtnDidTap() called")
    }
    
    @objc func showAllGradeBtnDidTap() {
        print("ProfileViewHeader = showAllGradeBtnDidTap() called")
    }
    
    @objc func showNextMonthGradeBtnDidTap() {
        print("ProfileViewHeader = showNextMonthGradeBtnDidTap() called")
    }
    
    @objc func loginOrJoinBtnDidTap() {
        delegate?.popupLoginViewController()
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func showLoginUI(_ bool: Bool) {
        gradeLabel.isHidden = !bool
        userNameLabel.isHidden = !bool
        pointPercentageLabel.isHidden = !bool
        showAllGradeBtn.isHidden = !bool
        showNextMonthGradeBtn.isHidden = !bool
    }
    
    func showLogoutUI(_ bool: Bool) {
        welcomeTextLabel.isHidden = !bool
        showRewardBtn.isHidden = !bool
        loginOrJoinBtn.isHidden = !bool
    }
    
    
    func configureUI(isLoggedIn: Bool) {
        
        // 나중에는 user객체 가져와서 모든 값들 채워넣어주면 된다. 이름, 등급, 적립률, (객체 있으면 login 없으면 logout)
        if isLoggedIn {
            
            showLoginUI(isLoggedIn)
            showLogoutUI(!isLoggedIn)
            
            addSubview(gradeLabel)
            gradeLabel.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 26, paddingLeft: 16)
            gradeLabel.setDimensions(height: 40, width: 40)
            gradeLabel.text = "일반"
            
            addSubview(userNameLabel)
            userNameLabel.centerY(inView: gradeLabel)
            userNameLabel.anchor(left: gradeLabel.rightAnchor, paddingLeft: 16)
            userNameLabel.text = "유정모님"
            
            addSubview(pointPercentageLabel)
            pointPercentageLabel.anchor(top: gradeLabel.bottomAnchor, left: self.leftAnchor, paddingTop: 28, paddingLeft: 16)
            pointPercentageLabel.text = "적립 0.5%"
            
            let stack = UIStackView(arrangedSubviews: [showAllGradeBtn, showNextMonthGradeBtn])
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 12
            
            addSubview(stack)
            stack.anchor(top: pointPercentageLabel.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor,
                         paddingTop: 32, paddingLeft: 16, paddingRight: 16)
            
        } else {
            
            showLoginUI(isLoggedIn)
            showLogoutUI(!isLoggedIn)
            
            gradeLabel.isHidden = true
            userNameLabel.isHidden = true
            pointPercentageLabel.isHidden = true
            showAllGradeBtn.isHidden = true
            showNextMonthGradeBtn.isHidden = true
            
            addSubview(welcomeTextLabel)
            welcomeTextLabel.text = "회원 가입하고\n다양한 혜택을 받아보세요!"
            welcomeTextLabel.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor,
                                    paddingTop: 28, paddingLeft: 16, paddingRight: 16)
            
            addSubview(showRewardBtn)
            showRewardBtn.anchor(top: welcomeTextLabel.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor,
                                 paddingTop: 10, paddingLeft: 16, paddingRight: 16)
            
            addSubview(loginOrJoinBtn)
            loginOrJoinBtn.anchor(top: showRewardBtn.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor,
                                  paddingTop: 24, paddingLeft: 16, paddingRight: 16 )
            loginOrJoinBtn.setHeight(50)
        }
    }
}
