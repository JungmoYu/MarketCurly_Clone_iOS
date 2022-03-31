//
//  JoinViewCell.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/21.
//

import UIKit

protocol JoinViewCellDelegate: AnyObject {
    func requestJoin(_ userInfo: JoinUserRequest)
    func requestUpdate(_ userInfo: UpdateUserRequest)
}

class JoinViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: JoinViewCell.self)
    weak var delegate: JoinViewCellDelegate?
    weak var viewController: UIViewController?
    
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
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let confirmPasswordTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "비밀번호를 한번 더 입력해주세요")
        tf.layer.cornerRadius = 3
        tf.isSecureTextEntry = true
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
    
    
    private lazy var agreeText: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText(text: "이용약관동의")
        return label
    }()
    
    private let totalAgreeLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 동의합니다."
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "선택 항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 있습니다."
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black.withAlphaComponent(0.5)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var essentialAgreeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedTwoText(text: "이용약관 동의", subText: "필수")
        return label
    }()
    
    private lazy var personalEssensialInfoLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedTwoText(text: "개인정보 수입﹒이용 동의", subText: "필수")
        return label
    }()
    
    private lazy var personalOptionalInfoLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedTwoText(text: "개인정보 수입﹒이용 동의", subText: "선택")
        return label
    }()
    
    private lazy var freeshipLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedTwoText(text: "무료배송, 할인쿠폰 등 혜택/정보 수신 동의", subText: "선택")
        return label
    }()
    
    private let SMSLabel: UILabel = {
        let label = UILabel()
        label.text = "SMS"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let emailLabel2: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var overFourteenLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedTwoText(text: "본인은 만 14세 이상입니다.", subText: "필수")
        return label
    }()
    
    private lazy var totalAgreeCheckBtn = createCheckBtn(isTotalAgree: true)
    private lazy var agreeCheckBtn = createCheckBtn(isTotalAgree: false)
    private lazy var personalEssensialInfoCheckBtn = createCheckBtn(isTotalAgree: false)
    private lazy var personalOptionalInfoCheckBtn = createCheckBtn(isTotalAgree: false)
    private lazy var freeshipCheckBtn = createCheckBtn(isTotalAgree: false)
    private lazy var SMSCheckBtn = createCheckBtn(isTotalAgree: false)
    private lazy var emailCheckBtn = createCheckBtn(isTotalAgree: false)
    private lazy var overFourteenCheckBtn = createCheckBtn(isTotalAgree: false)
    private lazy var btnArray = [agreeCheckBtn, personalEssensialInfoCheckBtn, personalOptionalInfoCheckBtn,
                                 freeshipCheckBtn, SMSCheckBtn, emailCheckBtn, overFourteenCheckBtn]
    
    private let rewardImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "동의혜택")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var joinBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .mainPurple
        btn.setTitle("가입하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(joinBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var updateBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .mainPurple
        btn.setTitle("수정하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(updateBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Actions
    
    @objc func IDCheckBtnDidTap() {
        print("UICollectionViewCell - IDCheckBtnDidTap() called")
    }
    
    @objc func requestAuthBtnDidTap() {
        print("UICollectionViewCell - requestAuthBtnDidTap() called")
    }
    
    @objc func dismissKeyboard() {
        endEditing(false)
    }
    
    @objc func joinBtnDidTap() {
        
        let userInfo = JoinUserRequest(id: IDTextField.text ?? "",
                                       password: passwordTextField.text ?? "",
                                       name: nameTextField.text ?? "",
                                       email: emailTextField.text ?? "",
                                       phone: mobilePhoneTextField.text ?? "",
                                       address: addressTextField.text,
                                       birthday: "1991.11.25",
                                       gender: "Male")
        
        if IDTextField.text == "" {
            viewController?.presentAlert(title: "아이디를 입력해주세요")
        }
        else if passwordTextField.text != confirmPasswordTextField.text {
            viewController?.presentAlert(title: "비밀번호가 일치하지 않습니다")
        } else if !checkBtnChecked() {
            viewController?.presentAlert(title: "필수 항목을 체크해 주세요!")
        } else {
            delegate?.requestJoin(userInfo)
        }
        
    }
    
    
    @objc func updateBtnDidTap() {
        let userInfo = UpdateUserRequest(password: passwordTextField.text ?? "",
                                         email: emailTextField.text ?? "",
                                         phone: mobilePhoneTextField.text ?? "",
                                         address: addressTextField.text ?? "",
                                         birthday: "1991.11.25",
                                         gender: "M")
        delegate?.requestUpdate(userInfo)
    }
    
    @objc func checkBtnDidTap(_ sender: UIButton) {
        
//        sender.isSelected = !sender.isSelected
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
            sender.backgroundColor = .clear
        } else {
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            sender.backgroundColor = .clear
        }
        
        if sender.tag == Constant.TOTAL_AGREE_BTN_TAG {
            btnArray.forEach {
                $0.isSelected = sender.isSelected
                if $0.isSelected {
                } else {
                }
            }
        }
        

            
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func checkBtnChecked() -> Bool {
        if agreeCheckBtn.isSelected && personalOptionalInfoCheckBtn.isSelected
            && freeshipCheckBtn.isSelected && overFourteenCheckBtn.isSelected {
            return true
        } else {
            return false
        }
    }
    
    func attributedText(text: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "*", attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                           .foregroundColor: UIColor.red]))
        return attributedText
    }
    
    func attributedTwoText(text: String, subText: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 16)])
        attributedText.append(NSAttributedString(string: " (\(subText))", attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                               .foregroundColor: UIColor.lightGray.withAlphaComponent(0.8)]))
        return attributedText
    }
    
    func createCheckBtn1(isTotalAgree: Bool) -> CustomCheckButton {
        let btn = CustomCheckButton(type: .system)
        btn.setDimensions(height: 30, width: 30)
        btn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        btn.tintColor = .lightGray.withAlphaComponent(0.5)
        btn.addTarget(self, action: #selector(checkBtnDidTap(_:)), for: .touchUpInside)
        btn.isSelected = false
        if isTotalAgree {
            btn.tag = Constant.TOTAL_AGREE_BTN_TAG
        }
        return btn
    }
    
    func createCheckBtn(isTotalAgree: Bool) -> RoundButton {
        let btn = RoundButton(type: .system)
        btn.setDimensions(height: 30, width: 30)
        btn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        btn.tintColor = .lightGray.withAlphaComponent(0.5)
        btn.addTarget(self, action: #selector(checkBtnDidTap(_:)), for: .touchUpInside)
        btn.isSelected = false
        if isTotalAgree {
            btn.tag = Constant.TOTAL_AGREE_BTN_TAG
        }
        return btn
    }
    
    func configureUI(isUpdating: Bool) {
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
        
        if isUpdating {
            IDLabel.removeFromSuperview()
            IDStack.removeFromSuperview()
            nameLabel.removeFromSuperview()
            nameTextField.removeFromSuperview()
            passwordLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
            emailLabel.anchor(top: confirmPasswordTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,
                              paddingTop: 20, paddingLeft: 16, paddingRight: 16)
            addSubview(updateBtn)
            updateBtn.setHeight(50)
            updateBtn.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor,
                           paddingLeft: 16, paddingBottom: 10, paddingRight: 16)
        } else {
            let bigDivider = UIView()
            bigDivider.backgroundColor = .lightGray.withAlphaComponent(0.15)
            addSubview(bigDivider)
            bigDivider.anchor(top: addressDescriptionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 30)
            bigDivider.setHeight(15)
            
            addSubview(agreeText)
            agreeText.anchor(top: bigDivider.bottomAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
            
            let totalAgreeStack = UIStackView(arrangedSubviews: [totalAgreeCheckBtn, totalAgreeLabel])
            totalAgreeStack.spacing = 5
            totalAgreeStack.distribution = .fill
            
            addSubview(totalAgreeStack)
            totalAgreeStack.anchor(top: agreeText.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                   paddingTop: 24, paddingLeft: 16, paddingRight: 16)
            
            addSubview(descriptionLabel)
            descriptionLabel.anchor(top: totalAgreeStack.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                    paddingTop: 16, paddingLeft: 16, paddingRight: 16)
            
            let divider = UIView()
            divider.backgroundColor = .lightGray.withAlphaComponent(0.5)
            divider.setHeight(0.5)
            
            addSubview(divider)
            divider.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                           paddingTop: 16, paddingLeft: 16, paddingRight: 16)
            
            let agreeStack = UIStackView(arrangedSubviews: [agreeCheckBtn, essentialAgreeLabel])
            agreeStack.spacing = 5
            agreeStack.distribution = .fill
            
            addSubview(agreeStack)
            agreeStack.anchor(top: divider.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                       paddingTop: 16, paddingLeft: 16, paddingRight: 16)
            
            let personalEssentialStack = UIStackView(arrangedSubviews: [personalEssensialInfoCheckBtn, personalEssensialInfoLabel])
            personalEssentialStack.spacing = 5
            personalEssentialStack.distribution = .fill
            
            addSubview(personalEssentialStack)
            personalEssentialStack.anchor(top: agreeStack.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                          paddingTop: 16, paddingLeft: 16, paddingRight: 16)
            
            let personalOptionalStack = UIStackView(arrangedSubviews: [personalOptionalInfoCheckBtn, personalOptionalInfoLabel])
            personalOptionalStack.spacing = 5
            personalOptionalStack.distribution = .fill
            
            addSubview(personalOptionalStack)
            personalOptionalStack.anchor(top: personalEssentialStack.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                          paddingTop: 16, paddingLeft: 16, paddingRight: 16)
            
            let freeshipStack = UIStackView(arrangedSubviews: [freeshipCheckBtn, freeshipLabel])
            freeshipStack.spacing = 5
            freeshipStack.distribution = .fill
            
            addSubview(freeshipStack)
            freeshipStack.anchor(top: personalOptionalStack.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                          paddingTop: 16, paddingLeft: 16, paddingRight: 16)
            
            let SMSstack = UIStackView(arrangedSubviews: [SMSCheckBtn, SMSLabel])
            SMSstack.spacing = 5
            SMSstack.distribution = .fill
            
            let emailStack = UIStackView(arrangedSubviews: [emailCheckBtn, emailLabel2])
            emailStack.spacing = 5
            emailStack.distribution = .fill
            
            let optionalStack = UIStackView(arrangedSubviews: [SMSstack, emailStack])
            optionalStack.spacing = 32
            optionalStack.distribution = .fillProportionally
            
            addSubview(optionalStack)
            optionalStack.anchor(top: freeshipStack.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                 paddingTop: 16, paddingLeft: 48, paddingRight: 16)
            
            addSubview(rewardImageView)
            rewardImageView.anchor(top: optionalStack.bottomAnchor, left: optionalStack.leftAnchor, right: emailCheckBtn.rightAnchor,
                                   paddingTop: 5)
            rewardImageView.setHeight(80)
            
            let overFourteenStack = UIStackView(arrangedSubviews: [overFourteenCheckBtn, overFourteenLabel])
            overFourteenStack.spacing = 5
            overFourteenStack.distribution = .fill
            
            addSubview(overFourteenStack)
            overFourteenStack.anchor(top: rewardImageView.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                     paddingTop: 16, paddingLeft: 16, paddingRight: 16)
            
            addSubview(joinBtn)
            joinBtn.setHeight(50)
            joinBtn.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor,
                           paddingLeft: 16, paddingBottom: 10, paddingRight: 16)
        }
        
        
        
    }
    
    // MARK: 빈 화면을 눌렀을 때 키보드가 내려가도록 처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    //        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
}



