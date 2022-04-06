//
//  CartViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/27.
//

import UIKit

class CartViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var cartList: [CartListResult] = []
    private var numOfItem: [Int] = []
    private var isChecked: [Bool] = []
    
    var totalPrice: Int = 0
    var totalNumOfItem: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return cv
    }()
    
    
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
        pushItemDetailViewController(withItem: cartList)
    }
    
    @objc func cancelBtnDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadViews()
    }
    
    // MARK: - Helpers
    
    func reloadViews() {
        cartList = []
        numOfItem = []
        ItemManagementManager().getCartList() { result in
            switch result {
            case .success(let data):
                if let result = data.result {
                    result.enumerated().forEach {
                        self.numOfItem.append($1.quantity)
                        self.cartList.append($1)
                        self.isChecked.append(true)
                    }
                }
                self.configureUI()
                self.buyBtn.setTitle(self.changeBtnTitle(), for: .normal)
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
 

    func configureUI() {
        view.addSubview(cancelBtn)
        cancelBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingLeft: 16)
        
        view.addSubview(loginLabel)
        loginLabel.centerX(inView: view)
        loginLabel.centerY(inView: cancelBtn)
        
        
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

        view.addSubview(buyBtn)
        buyBtn.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                      paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: divider.bottomAnchor, left: view.leftAnchor, bottom: buyBtn.topAnchor, right: view.rightAnchor, paddingBottom: 10)

    }
    
    func changeBtnTitle() -> String {
        var str: String = ""
        totalPrice = 0
        totalNumOfItem = numOfItem.reduce(0) { $0 + $1 }
        if totalNumOfItem == 0 {
            str = "상품을 선택해주세요"
            buyBtn.isEnabled = false
            buyBtn.backgroundColor = .lightGray.withAlphaComponent(0.5)
        } else {
            for (index, _) in numOfItem.enumerated() {
                if isChecked[index] {
                    totalPrice += numOfItem[index] * Int(Double(self.cartList[index].item_price))
                }
                str = String(totalPrice).insertComma + "원 주문하기"
                buyBtn.backgroundColor = .mainPurple
                buyBtn.isEnabled = true
            }
            if totalPrice == 0 {
                str = "상품을 선택해주세요"
                buyBtn.isEnabled = false
                buyBtn.backgroundColor = .lightGray.withAlphaComponent(0.5)
            }
            
        }
        return str

    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cartViewNoItemCell.self, forCellWithReuseIdentifier: cartViewNoItemCell.identifier)
        collectionView.register(cartViewCollectionViewCell.self, forCellWithReuseIdentifier: cartViewCollectionViewCell.identifier)
        collectionView.register(CartViewFooterCell.self, forCellWithReuseIdentifier: CartViewFooterCell.identifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(150)),
                                                               subitem: item,
                                                               count: 1)
            
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(200)),
                                                               subitem: item,
                                                               count: 1)
            
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
            

        }
        return layout
    }
    

}


extension CartViewController: UICollectionViewDelegate {
    
}

extension CartViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if cartList.count == 0 {
                return 1
            } else {
                return cartList.count
            }
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if cartList.count != 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cartViewCollectionViewCell.identifier,
                                                              for: indexPath) as! cartViewCollectionViewCell
                cell.delegate = self
                cell.viewController = self
                cell.numOfItem = numOfItem[indexPath.item]
                cell.configureBtnState(isChecked[indexPath.item])
                cell.configureUI(cartList[indexPath.item])
                cell.numOfItemAt = indexPath.item
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cartViewNoItemCell.identifier,
                                                              for: indexPath) as! cartViewNoItemCell
                cell.configureUI()
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartViewFooterCell.identifier,
                                                          for: indexPath) as! CartViewFooterCell
            cell.configureUI(price: totalPrice,
                             deliveryCost: totalPrice > 30000 ? 0 : 3000,
                             needCost: totalPrice > 30000 ? 0 : 30000 - totalPrice,
                             isFreeShip: totalPrice > 30000 ? true : false)
            return cell
        }
        
        
    }
    
    func pushItemDetailViewController(withItem: [CartListResult]) {
        let controller = OrderViewController()
        controller.cartList = cartList
        controller.totalPrice = totalPrice
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension CartViewController: cartViewCollectionViewCellDelegate {
    func deleteBtnDidTap(itemAt: Int) {
        let itemID = String(cartList[itemAt].item_id)
        deleteRequest(itemID: itemID)
    }
    
    func checkBtnDidTap(isChecked: Bool, itemAt: Int) {
        self.isChecked[itemAt] = isChecked
        buyBtn.setTitle(changeBtnTitle(), for: .normal)
        collectionView.reloadData()
    }
    
    func minusBtnDidTap(itemAt: Int) {
        if numOfItem[itemAt] > 1 {
            buyBtn.isEnabled = true
            numOfItem[itemAt] -= 1
            
            let itemID = String(cartList[itemAt].item_id)
            let numOfItemToUpdate = String(numOfItem[itemAt])
            
            updateRequest(itemID: itemID, numOfItemToUpdate: numOfItemToUpdate)
        } else {
            self.presentAlert(title: "상품은 최소 1개 이상이어야 합니다")
            buyBtn.isEnabled = false
        }
        buyBtn.setTitle(changeBtnTitle(), for: .normal)
        collectionView.reloadData()
    }
    
    func plusBtnDidTap(itemAt: Int) {
        numOfItem[itemAt] += 1
        
        let itemID = String(cartList[itemAt].item_id)
        let numOfItemToUpdate = String(numOfItem[itemAt])
        
        updateRequest(itemID: itemID, numOfItemToUpdate: numOfItemToUpdate)
        buyBtn.setTitle(changeBtnTitle(), for: .normal)
        collectionView.reloadData()
    }
    
    func updateRequest(itemID: String, numOfItemToUpdate: String) {
        ItemManagementManager().updateCart(itemID: itemID, numOfItemToUpdate: numOfItemToUpdate) { result in
            switch result{
            case .success(let data):
                if data.isSuccess {
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
    
    func deleteRequest(itemID: String) {
        ItemManagementManager().deleteItemFromCart(itemID: itemID) { result in
            switch result{
            case .success(let data):
                if data.isSuccess {
                }
                self.reloadViews()
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
}


// MARK: - Cells

class cartViewNoItemCell: UICollectionViewCell {
    
    // Properties
    
    static let identifier: String = String(describing: cartViewNoItemCell.self)
    
    private let noItemLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "장바구니에 담긴 상품이 없습니다"
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private let noOrderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "주문 목록이 없습니다"
        label.textColor = .lightGray
        label.textAlignment = .center
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
    func configureUI() {
        addSubview(noItemLabel)
        noItemLabel.fillSuperview()
    }
    
    func configureUIForNoOrder() {
        addSubview(noOrderLabel)
        noItemLabel.fillSuperview()
    }
}


protocol cartViewCollectionViewCellDelegate: AnyObject {
    func minusBtnDidTap(itemAt: Int)
    func plusBtnDidTap(itemAt: Int)
    func checkBtnDidTap(isChecked: Bool, itemAt: Int)
    func deleteBtnDidTap(itemAt: Int)
}

class cartViewCollectionViewCell: UICollectionViewCell {
    
    // Properties
    
    static let identifier: String = String(describing: cartViewCollectionViewCell.self)
    var numOfItem: Int = 0
    var numOfItemAt: Int = 0
    var viewController: UIViewController?
    weak var delegate: cartViewCollectionViewCellDelegate?
    
    private lazy var checkBtn = createCheckBtn(isTotalAgree: false)
    
    private let titleNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("𝖷", for: .normal)
        btn.tintColor = .gray
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(cancelBtnDidTap), for: .touchUpInside)
        return btn
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
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var minusBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "minus"), for: .normal)
        btn.setDimensions(height: 20, width: 20)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(minusBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var plusBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.setDimensions(height: 20, width: 20)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(plusBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private let numOfItemLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    // Action
    @objc func checkBtnDidTap(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
        sender.changeColor()
        delegate?.checkBtnDidTap(isChecked: sender.isSelectedBtn(), itemAt: numOfItemAt)
    }
    
    @objc func cancelBtnDidTap() {
        viewController?.presentAlert(title: "상품 삭제", message: "삭제하시겠습니까?", isCancelActionIncluded: true) { isYes in
            self.delegate?.deleteBtnDidTap(itemAt: self.numOfItemAt)
        }
    }
    
    @objc func minusBtnDidTap() {
        delegate?.minusBtnDidTap(itemAt: numOfItemAt)
    }
    
    @objc func plusBtnDidTap() {
        delegate?.plusBtnDidTap(itemAt: numOfItemAt)
    }
    
    // Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Helpers
    func configureBtnState(_ isChecked: Bool) {
//        checkBtn.isSelected = isChecked
//        
        checkBtn.setSelectedBtn(isChecked)
        
    }
    
    func configureUI(order: OrderListResult) {
        addSubview(titleNameLabel)
        titleNameLabel.text = "[" + order.vendor + "]" + order.title
        titleNameLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(itemNameLabel)
        itemNameLabel.text = "[" + order.vendor + "]" + order.item_name
        itemNameLabel.anchor(top: titleNameLabel.bottomAnchor, left: titleNameLabel.leftAnchor, paddingTop: 5)
        
        addSubview(imageView)
        let url = URL(string: order.image)
        imageView.load(url: url!)
        imageView.anchor(top: itemNameLabel.bottomAnchor, left: itemNameLabel.leftAnchor, paddingTop: 12)
        
        addSubview(priceLabel)
        priceLabel.text = String(order.item_price).insertComma + "원"
        priceLabel.anchor(top: imageView.topAnchor, left: imageView.rightAnchor, paddingLeft: 16)
        
        addSubview(numOfItemLabel)
        numOfItemLabel.text = "구매 수단 : " + order.pay
        numOfItemLabel.anchor(top: priceLabel.bottomAnchor, left: imageView.rightAnchor, paddingTop: 10, paddingLeft: 16)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray.withAlphaComponent(0.5)
        divider.setHeight(0.5)
        
        addSubview(divider)
        divider.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    
    func configureUI(_ cartItem: CartListResult) {
    
        addSubview(checkBtn)
        checkBtn.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        addSubview(titleNameLabel)
        titleNameLabel.text = "[" + cartItem.vendor + "]" + cartItem.title
        titleNameLabel.centerY(inView: checkBtn)
        titleNameLabel.anchor(left: checkBtn.rightAnchor, paddingLeft: 10)
        
        
        addSubview(cancelBtn)
        cancelBtn.centerY(inView: checkBtn)
        cancelBtn.anchor(right: rightAnchor, paddingRight: 16)
        
        addSubview(itemNameLabel)
        itemNameLabel.text = "[" + cartItem.vendor + "]" + cartItem.item_name
        itemNameLabel.anchor(top: titleNameLabel.bottomAnchor, left: titleNameLabel.leftAnchor, paddingTop: 5)
        
        
        addSubview(imageView)
        let url = URL(string: cartItem.image)
        imageView.load(url: url!)
        imageView.anchor(top: itemNameLabel.bottomAnchor, left: itemNameLabel.leftAnchor, paddingTop: 12)
        
        addSubview(priceLabel)
        priceLabel.text = String(cartItem.item_price).insertComma + "원"
        priceLabel.anchor(top: imageView.topAnchor, left: imageView.rightAnchor, paddingLeft: 16)
        
        let numOfItemStack = UIStackView(arrangedSubviews: [minusBtn, numOfItemLabel, plusBtn])
        numOfItemLabel.text = String(numOfItem)
        numOfItemStack.spacing = 5
        numOfItemStack.layer.borderColor = UIColor.lightGray.cgColor
        numOfItemStack.layer.borderWidth = 0.5
        numOfItemStack.layer.cornerRadius = 2
        numOfItemStack.isLayoutMarginsRelativeArrangement = true
        numOfItemStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        addSubview(numOfItemStack)
        numOfItemStack.anchor(left: priceLabel.leftAnchor, bottom: imageView.bottomAnchor)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        divider.setHeight(0.5)
        
        addSubview(divider)
        divider.anchor(left: imageView.leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
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
}


class CartViewFooterCell: UICollectionViewCell {

    // Properties
    
    static let identifier: String = String(describing: CartViewFooterCell.self)
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "상품금액"
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
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainPurple
        return label
    }()
    
    private let totalCostLabel: UILabel = {
        let label = UILabel()
        label.text = "결제예정금액"
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
    
    private let pointLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let couponLabel: UILabel = {
        let label = UILabel()
        label.text = "쿠폰/적립금은 주문서에서 사용 가능합니다"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
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
    
    func configureUI(price: Int, deliveryCost: Int, needCost: Int, isFreeShip: Bool) {
        
        let divider = UIView()
        divider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        divider.setHeight(10)
        
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        
        addSubview(productPriceLabel)
        productPriceLabel.anchor(top: divider.bottomAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        addSubview(productPriceLabelText)
        productPriceLabelText.text = String(price).insertComma + "원"
        productPriceLabelText.anchor(top: divider.bottomAnchor, right: rightAnchor, paddingTop: 16, paddingRight: 16)
        
        addSubview(deliveryCostLabel)
        deliveryCostLabel.anchor(top: productPriceLabel.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        addSubview(deliveryCostLabelText)
        deliveryCostLabelText.text = "+" + String(deliveryCost).insertComma + "원"
        deliveryCostLabelText.anchor(top: productPriceLabel.bottomAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 16)
        
        addSubview(descriptionLabel)
        if !isFreeShip {
            descriptionLabel.text = String(needCost).insertComma + "원 추가주문 시, 무료배송"
        } else {
            descriptionLabel.text = "무료배송"
        }
        descriptionLabel.anchor(top: deliveryCostLabelText.bottomAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 16)
        
        let smallDivider = UIView()
        smallDivider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        smallDivider.setHeight(0.5)
        addSubview(smallDivider)
        smallDivider.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
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
        
        addSubview(pointLabel)
        pointLabel.text = "구매 시 " + String(Int(Double(price) * 0.005)).insertComma + "원 적립"
        pointLabel.anchor(top: totalCostLabel.bottomAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 16)
        
        addSubview(couponLabel)
        couponLabel.anchor(top: pointLabel.bottomAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 16)
    }
}
