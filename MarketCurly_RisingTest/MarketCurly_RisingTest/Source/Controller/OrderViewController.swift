//
//  OrderViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/31.
//

import UIKit

class OrderViewController: BaseViewController {
    
    // MARK: - Properties
    
    var cartList: [CartListResult] = []
//    var orderList: [Order] = []
    var orderList: [Int] = []
    var totalPrice: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return cv
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "주문서"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("<", for: .normal)
        btn.tintColor = .black
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(cancelBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Action
    
    @objc func cancelBtnDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(cancelBtn)
        cancelBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingLeft: 16)
        
        view.addSubview(loginLabel)
        loginLabel.centerX(inView: view)
        loginLabel.centerY(inView: cancelBtn)
        
        let divider = UIView()
        divider.backgroundColor = .black
        divider.setHeight(0.5)
        view.addSubview(divider)
        divider.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 36)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: divider.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OrderViewControllerItemCell.self, forCellWithReuseIdentifier: OrderViewControllerItemCell.identifier)
        collectionView.register(OrderViewControllerInfoCell.self, forCellWithReuseIdentifier: OrderViewControllerInfoCell.identifier)
        collectionView.register(OrderViewControllerHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: OrderViewControllerHeader.identifier)
    }
    
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(100)),
                                                               subitem: item,
                                                               count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                            heightDimension: .absolute(50)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                section.boundarySupplementaryItems.append(header)
                return section
            
            } else if sectionIndex == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(1130)),
                                                               subitem: item,
                                                               count: 1)
                
                
            
                let section = NSCollectionLayoutSection(group: group)
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                            heightDimension: .absolute(50)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                section.boundarySupplementaryItems.append(header)
                
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(50)),
                                                               subitem: item,
                                                               count: 1)
            
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
            

        }
        return layout
    }
    

}


extension OrderViewController: UICollectionViewDelegate {
    
}

extension OrderViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return cartList.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderViewControllerItemCell.identifier,
                                                          for: indexPath) as! OrderViewControllerItemCell
            cell.configureUI(item: cartList[indexPath.item])
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderViewControllerInfoCell.identifier,
                                                          for: indexPath) as! OrderViewControllerInfoCell
            cell.configureUI(price: totalPrice,
                             deliveryCost: totalPrice > 30000 ? 0 : 3000,
                             isFreeShip: totalPrice > 30000 ? true : false)
            cell.totalPrice = totalPrice
            cell.viewController = self
            cell.delegate = self

            return cell

        } else { return UICollectionViewCell() }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                             withReuseIdentifier: OrderViewControllerHeader.identifier,
                                             for: indexPath) as! OrderViewControllerHeader
            header.configureHeaderText("주문상품")
            return header
        } else if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                             withReuseIdentifier: OrderViewControllerHeader.identifier,
                                             for: indexPath) as! OrderViewControllerHeader
            header.configureHeaderText("주문자 정보")
            return header
        } else if indexPath.section == 2 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                             withReuseIdentifier: OrderViewControllerHeader.identifier,
                                             for: indexPath) as! OrderViewControllerHeader
            header.configureHeaderText("배송지")
            return header
        } else { return UICollectionReusableView() }
    }
    
}

extension OrderViewController: OrderViewControllerInfoCellDelegate {
    func buyBtnDidTap(with payment: String) {
        orderList = []
        for (index, _) in cartList.enumerated() {
//            orderList.append(Order(basket_id: cartList[index].basket_id))
            orderList.append(cartList[index].basket_id)
        }
        let order = OrderRequest(orderList: orderList, pay: payment)
        
        ItemManagementManager().makeOrder(order: order) { result in
            switch result {
            case .success(let data):
                print(data.message)
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
}




// MARK: - Cells

class OrderViewControllerHeader: UICollectionReusableView {
    // Properties
    
    static let identifier: String = String(describing: OrderViewControllerHeader.self)
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    // Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Helpers
    func configureHeaderText(_ text: String) {
        let divider = UIView()
        divider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        divider.setHeight(10)
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        
        addSubview(textLabel)
        textLabel.text = text
        textLabel.anchor(top: divider.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
    }
    
    
}

class OrderViewControllerItemCell: UICollectionViewCell {
    
    // Properties
    
    static let identifier: String = String(describing: OrderViewControllerItemCell.self)
    
    private let titleNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.setDimensions(height: 60, width: 50)
        iv.backgroundColor = .red
        return iv
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let numOfItemLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    
        // Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Helpers
    
    func configureUI(item: CartListResult) {
        let url = URL(string: item.image)
        imageView.load(url: url!)
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(titleNameLabel)
        titleNameLabel.text = "[" + item.vendor + "] " + item.item_name
        titleNameLabel.anchor(top: imageView.topAnchor, left: imageView.rightAnchor, paddingLeft: 16)
        
        addSubview(priceLabel)
        priceLabel.text = String(item.item_price).insertComma + "원"
        priceLabel.anchor(left: imageView.rightAnchor, bottom: imageView.bottomAnchor, paddingLeft: 16, paddingBottom: 5)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        divider.setWidth(0.5)
        
        addSubview(divider)
        divider.anchor(top: priceLabel.topAnchor, left: priceLabel.rightAnchor, bottom: priceLabel.bottomAnchor, paddingLeft: 8)
        
        addSubview(numOfItemLabel)
        numOfItemLabel.text = String(item.quantity) + "개"
        numOfItemLabel.anchor(top: priceLabel.topAnchor, left: divider.rightAnchor, paddingLeft: 8)
        
        let hDivider = UIView()
        hDivider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        hDivider.setHeight(0.5)
        addSubview(hDivider)
        hDivider.anchor(top: imageView.bottomAnchor, left: titleNameLabel.leftAnchor, right: rightAnchor, paddingTop: 10)
        
    }
}

protocol OrderViewControllerInfoCellDelegate: AnyObject {
    func buyBtnDidTap(with payment: String)
}

class OrderViewControllerInfoCell: UICollectionViewCell {
    
    // Properties
    
    static let identifier: String = String(describing: OrderViewControllerInfoCell.self)
    weak var delegate: OrderViewControllerInfoCellDelegate?
    var viewController: UIViewController?
    var paymant: String = "카카오페이"
    var totalPrice: Int = 0
    
    private let senderName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "보내는 분"
        label.textColor = .gray
        return label
    }()
    
    private let senderNameText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "휴대폰"
        label.textColor = .gray
        return label
    }()
    
    private let phoneLabelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "이메일"
        label.textColor = .gray
        return label
    }()
    
    private let emailLabelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "배송지"
        label.textColor = .gray
        return label
    }()
    
    private let addressLabelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let couponImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "결제_쿠폰")
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private let paymentLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "결제수단"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "결제금액"
        return label
    }()
    
    private lazy var kakaoBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("카카오페이", for: .normal)
        btn.setHeight(50)
        btn.setTitleColor(.black, for: .normal)
        btn.tag = 1
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.tintColor = .systemYellow
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(paymentBtnDidTap(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var creditcartBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("신용카드", for: .normal)
        btn.setHeight(50)
        btn.setTitleColor(.black, for: .normal)
        btn.tag = 2
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.tintColor = .mainPurple
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(paymentBtnDidTap(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var easyPayBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("체크카드", for: .normal)
        btn.setHeight(50)
        btn.setTitleColor(.black, for: .normal)
        btn.tag = 3
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.tintColor = .mainPurple
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(paymentBtnDidTap(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var phoneBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("휴대폰", for: .normal)
        btn.setHeight(50)
        btn.setTitleColor(.black, for: .normal)
        btn.tag = 4
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.tintColor = .mainPurple
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(paymentBtnDidTap(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var btnArray = [kakaoBtn, creditcartBtn, easyPayBtn, phoneBtn]
    
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "주문금액"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let productPriceLabelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let deliveryCostLabel: UILabel = {
        let label = UILabel()
        label.text = "배송비"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let deliveryCostLabelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let totalCostLabel: UILabel = {
        let label = UILabel()
        label.text = "최종결제금액"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let totalCostLabelText: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let agreeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "결제_동의")
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private lazy var buyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .mainPurple
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(buyBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    
    // Action
    
    @objc func paymentBtnDidTap(_ sender: UIButton) {
        
        btnArray.forEach {
            $0.isSelected = false
            $0.changeBackgroundColor($0.isSelected)
        }
        sender.isSelected = true
        sender.changeBackgroundColor(sender.isSelected)
        
        switch sender.tag {
        case 1: paymant = "KAKAOPAY"
        case 2: paymant = "CREDITCARD"
        case 3: paymant = "DEBITCARD"
        case 4: paymant = "PHONE"
        default: return
        }
        
    }
    
    @objc func buyBtnDidTap() {
        viewController?.presentAlert(title: "최종 결제", message: paymant + "로 구매하시겠습니까?", isCancelActionIncluded: true) { isYes in
            self.delegate?.buyBtnDidTap(with: self.paymant)
            
        }
        
    }
    
        // Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Helpers
    
    func configureUI(price: Int, deliveryCost: Int, isFreeShip: Bool) {
        
        addSubview(senderName)
        senderName.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        addSubview(senderNameText)
        senderNameText.text = Constant.User?.name ?? ""
        senderNameText.anchor(top: topAnchor, left: senderName.rightAnchor, paddingTop: 16, paddingLeft: 30)
        
        addSubview(phoneLabel)
        phoneLabel.anchor(top: senderName.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(phoneLabelText)
        phoneLabelText.text = Constant.User?.phone ?? "휴대폰 정보가 없습니다."
        phoneLabelText.anchor(top: senderName.bottomAnchor, left: senderNameText.leftAnchor, paddingTop: 10)
        
        addSubview(emailLabel)
        emailLabel.anchor(top: phoneLabel.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(emailLabelText)
        emailLabelText.text = Constant.User?.email ?? ""
        emailLabelText.anchor(top: phoneLabel.bottomAnchor, left: senderNameText.leftAnchor, paddingTop: 10)
        
        addSubview(addressLabel)
        addressLabel.anchor(top: emailLabelText.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(addressLabelText)
        addressLabelText.text = Constant.User?.address ?? "주소가 입력되어있지 않습니다."
        addressLabelText.anchor(top: emailLabelText.bottomAnchor, left: senderNameText.leftAnchor, paddingTop: 10)
        
        addSubview(couponImageView)
        couponImageView.anchor(top: addressLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10)
        couponImageView.setHeight(300)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        divider.setHeight(10)
        addSubview(divider)
        divider.anchor(top: couponImageView.bottomAnchor, left: leftAnchor, right: rightAnchor)
        
        addSubview(paymentLabel)
        paymentLabel.anchor(top: divider.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(kakaoBtn)
        kakaoBtn.anchor(top: paymentLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                        paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        let btnStack = UIStackView(arrangedSubviews: [creditcartBtn, easyPayBtn, phoneBtn])
        btnStack.distribution = .fillEqually
        btnStack.spacing = 10
        
        addSubview(btnStack)
        btnStack.anchor(top: kakaoBtn.bottomAnchor, left: leftAnchor, right: rightAnchor,
                        paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        let divider2 = UIView()
        divider2.backgroundColor = .lightGray.withAlphaComponent(0.15)
        divider2.setHeight(10)
        addSubview(divider2)
        divider2.anchor(top: btnStack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10)
        
        addSubview(priceLabel)
        priceLabel.anchor(top: divider2.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(productPriceLabel)
        productPriceLabel.anchor(top: priceLabel.bottomAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        addSubview(productPriceLabelText)
        productPriceLabelText.text = String(price).insertComma + "원"
        productPriceLabelText.anchor(top: priceLabel.bottomAnchor, right: rightAnchor, paddingTop: 16, paddingRight: 16)
        
        addSubview(deliveryCostLabel)
        deliveryCostLabel.anchor(top: productPriceLabel.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        addSubview(deliveryCostLabelText)
        deliveryCostLabelText.text = "+" + String(deliveryCost).insertComma + "원"
        deliveryCostLabelText.anchor(top: productPriceLabel.bottomAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 16)
        
        let smallDivider = UIView()
        smallDivider.backgroundColor = .lightGray.withAlphaComponent(0.5)
        smallDivider.setHeight(0.5)
        addSubview(smallDivider)
        smallDivider.anchor(top: deliveryCostLabelText.bottomAnchor, left: leftAnchor, right: rightAnchor,
                            paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        addSubview(totalCostLabel)
        totalCostLabel.anchor(top: smallDivider.bottomAnchor, left: leftAnchor,
                              paddingTop: 10, paddingLeft: 16)
        
        addSubview(totalCostLabelText)
        if isFreeShip {
            totalCostLabelText.text = String(price).insertComma + "원"
        } else {
            totalCostLabelText.text = String(price + 3000).insertComma + "원"
        }
        totalCostLabelText.anchor(top: smallDivider.bottomAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 16)
        
        let divider3 = UIView()
        divider3.backgroundColor = .lightGray.withAlphaComponent(0.15)
        divider3.setHeight(10)
        addSubview(divider3)
        divider3.anchor(top: totalCostLabelText.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10)
        
        addSubview(agreeImageView)
        agreeImageView.anchor(top: divider3.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10)
        agreeImageView.setHeight(300)
        
        addSubview(buyBtn)
        buyBtn.setHeight(50)
        buyBtn.setTitle(String(price).insertComma + "원 결제하기", for: .normal)
        buyBtn.anchor(top: agreeImageView.bottomAnchor, left: leftAnchor, right: rightAnchor,
                      paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
    }
}

