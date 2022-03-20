//
//  JoinViewCell.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/21.
//

import UIKit

class JoinViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: JoinViewCell.self)
    
    private lazy var IDLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText(text: "아이디")
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText(text: "비밀번호")
        return label
    }()
    
    private lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText(text: "비밀번호 확인")
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText(text: "이름")
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText(text: "이메일")
        return label
    }()
    
    private lazy var mobilePhoneLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText(text: "휴대폰")
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText(text: "주소")
        return label
    }()
    
    private lazy var addressDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "배송지에 따라 상품 정보가 달라질 수 있습니다."
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray.withAlphaComponent(0.8)
        return label
    }()
    
    private let IDTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "예 : marketKurly12")
        tf.layer.cornerRadius = 3
        return tf
    }()
    
    private let passwordTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "비밀번호를 입력해주세요")
        tf.layer.cornerRadius = 3
        return tf
    }()
    
    private let confirmPasswordTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "비밀번호를 한번 더 입력해주세요")
        tf.layer.cornerRadius = 3
        return tf
    }()
    
    private let nameTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "이름을 입력해주세요")
        tf.layer.cornerRadius = 3
        return tf
    }()
    
    private let emailTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "예 : marketKurly@kurly.com")
        tf.layer.cornerRadius = 3
        return tf
    }()
    
    private let mobilePhoneTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "숫자만 입력해주세요")
        tf.layer.cornerRadius = 3
        return tf
    }()
    
    private let addressTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "도로명, 지번, 건물명 검색")
        tf.layer.cornerRadius = 3
        return tf
    }()
    
    private lazy var IDCheckBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setDimensions(height: 50, width: 80)
        btn.setTitle("중복확인", for: .normal)
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = UIColor.mainPurple.cgColor
        btn.layer.borderWidth = 1
        btn.setTitleColor(.mainPurple, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(IDCheckBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var requestAuthBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setDimensions(height: 50, width: 120)
        btn.setTitle("인증번호 받기", for: .normal)
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        btn.layer.borderWidth = 1
        btn.setTitleColor(.lightGray.withAlphaComponent(0.5), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(requestAuthBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Actions
    
    @objc func IDCheckBtnDidTap() {
        print("UICollectionViewCell - IDCheckBtnDidTap() called")
    }
    
    @objc func requestAuthBtnDidTap() {
        print("UICollectionViewCell - requestAuthBtnDidTap() called")
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func attributedText(text: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "*", attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                           .foregroundColor: UIColor.red]))
        return attributedText
    }
    
    func configureUI() {
        
        backgroundColor = .white
        
        addSubview(IDLabel)
        IDLabel.anchor(top: topAnchor, left: leftAnchor,paddingTop: 16, paddingLeft: 16)
        
        let IDStack = UIStackView(arrangedSubviews: [IDTextField, IDCheckBtn])
        IDStack.axis = .horizontal
        IDStack.spacing = 5
        IDStack.distribution = .fillProportionally
        
        addSubview(IDStack)
        IDStack.anchor(top: IDLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                       paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        addSubview(passwordLabel)
        passwordLabel.anchor(top: IDStack.bottomAnchor, left: leftAnchor, right: rightAnchor,
                             paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        addSubview(passwordTextField)
        passwordTextField.anchor(top: passwordLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                 paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        addSubview(confirmPasswordLabel)
        confirmPasswordLabel.anchor(top: passwordTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,
                             paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        addSubview(confirmPasswordTextField)
        confirmPasswordTextField.anchor(top: confirmPasswordLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                        paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        addSubview(nameLabel)
        nameLabel.anchor(top: confirmPasswordTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,
                         paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        addSubview(nameTextField)
        nameTextField.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                             paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        addSubview(emailLabel)
        emailLabel.anchor(top: nameTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,
                          paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        addSubview(emailTextField)
        emailTextField.anchor(top: emailLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                              paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        addSubview(mobilePhoneLabel)
        mobilePhoneLabel.anchor(top:emailTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        let phoneStack = UIStackView(arrangedSubviews: [mobilePhoneTextField, requestAuthBtn])
        phoneStack.axis = .horizontal
        phoneStack.spacing = 5
        phoneStack.distribution = .fillProportionally
        
        addSubview(phoneStack)
        phoneStack.anchor(top:mobilePhoneLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                          paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        addSubview(addressLabel)
        addressLabel.anchor(top:phoneStack.bottomAnchor, left: leftAnchor, right: rightAnchor,
                            paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        addSubview(addressTextField)
        addressTextField.anchor(top:addressLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        addSubview(addressDescriptionLabel)
        addressDescriptionLabel.anchor(top:addressTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                       paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        
    }
}
