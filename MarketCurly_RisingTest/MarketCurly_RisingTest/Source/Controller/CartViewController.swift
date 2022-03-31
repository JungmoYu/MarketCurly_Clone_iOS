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
        
    }
    
    @objc func cancelBtnDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func checkBtnDidTap(_ sender: UIButton) {
        
    }
    

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    // MARK: - Helpers
 

    func configureUI() {
        view.backgroundColor = .white
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
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .fractionalHeight(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .absolute(150)),
                                                           subitem: item,
                                                           count: 1)
        
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.bottom = 8
            
            return section

        }
        return layout
    }
    

}


extension CartViewController: UICollectionViewDelegate {
    
}

extension CartViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cartList.count == 0 {
            return 1
        } else {
            return cartList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
            return cell
        }
    }
    
    func pushItemDetailViewController(withItem: ItemInfoResult) {
        let controller = ItemDetailViewController()
        controller.navigationItem.title = withItem.title
        controller.itemInfo = withItem
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension CartViewController: cartViewCollectionViewCellDelegate {
    func checkBtnDidTap(isChecked: Bool, itemAt: Int) {
        self.isChecked[itemAt] = isChecked
        buyBtn.setTitle(changeBtnTitle(), for: .normal)
        collectionView.reloadItems(at: [IndexPath(item: itemAt, section: 0)])
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
        collectionView.reloadItems(at: [IndexPath(item: itemAt, section: 0)])
    }
    
    func plusBtnDidTap(itemAt: Int) {
        numOfItem[itemAt] += 1
        
        let itemID = String(cartList[itemAt].item_id)
        let numOfItemToUpdate = String(numOfItem[itemAt])
        
        updateRequest(itemID: itemID, numOfItemToUpdate: numOfItemToUpdate)
        buyBtn.setTitle(changeBtnTitle(), for: .normal)
        collectionView.reloadItems(at: [IndexPath(item: itemAt, section: 0)])
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
}


// MARK: - Cells

class cartViewNoItemCell: UICollectionViewCell {
    
    // Properties
    
    static let identifier: String = String(describing: cartViewNoItemCell.self)
    
    private let noItemLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "장바구니에 담긴 상품이 없습니다"
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
    func configureUI() {
        addSubview(noItemLabel)
        noItemLabel.fillSuperview()
    }
}


protocol cartViewCollectionViewCellDelegate: AnyObject {
    func minusBtnDidTap(itemAt: Int)
    func plusBtnDidTap(itemAt: Int)
    func checkBtnDidTap(isChecked: Bool, itemAt: Int)
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
        label.setDimensions(height: 20, width: 20)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    // Action
    @objc func checkBtnDidTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.checkBtnDidTap(isChecked: sender.isSelected, itemAt: numOfItemAt)
    }
    
    @objc func cancelBtnDidTap() {
        viewController?.presentAlert(title: "상품 삭제", message: "삭제하시겠습니까?", isCancelActionIncluded: true) { isYes in
//            self.delegate?.requestDeleteReview(reviewID: self.reviewID)
            print("상품 삭제 API")
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
        checkBtn.isSelected = isChecked
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
