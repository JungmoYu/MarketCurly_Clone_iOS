//
//  JoinViewFooter.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/21.
//

import UIKit

protocol JoinViewFooterDelegate: AnyObject {
    func requestJoin()
}

class JoinViewFooter: UICollectionReusableView {
    // MARK: - Properties
    
    static let identifier: String = String(describing: JoinViewFooter.self)
    weak var delegate: JoinViewFooterDelegate?
    
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
    
    private let emailLabel: UILabel = {
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
    
    // MARK: - Actions
    
    @objc func joinBtnDidTap() {
        print("JoinViewFooter - joinBtnDidTap() called")
        delegate?.requestJoin()
    }
    
    @objc func checkBtnDidTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            sender.tintColor = .mainPurple
        } else {
            sender.tintColor = .lightGray.withAlphaComponent(0.5)
        }
        
//        if sender.isSelected {
//            print("selected")
//            sender.tintColor = .mainPurple
//            sender.isSelected.toggle()
//        } else {
//            print("selected no")
//            sender.tintColor = .lightGray.withAlphaComponent(0.5)
//            sender.backgroundColor = .clear
//            sender.isSelected.toggle()
//        }
        
        // 여기서 체크되었는지에 따라 정보 저장해야함.
        if sender.tag == Constant.TOTAL_AGREE_BTN_TAG {
            
        }
            
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
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
    
    func attributedTwoText(text: String, subText: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 16)])
        attributedText.append(NSAttributedString(string: " (\(subText))", attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                               .foregroundColor: UIColor.lightGray.withAlphaComponent(0.8)]))
        return attributedText
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
    
    func configureUI() {
        
        addSubview(agreeText)
        agreeText.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
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
        
        let emailStack = UIStackView(arrangedSubviews: [emailCheckBtn, emailLabel])
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
