//
//  ItemThirdSubController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/22.
//

import UIKit

class ItemThirdSubController: BaseViewController {
    
    // MARK: - Properties
    
    var itemInfo: ItemInfoResult?
    private var reviews: [ReviewResponseResult] = []
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return cv
    }()
    
    private lazy var createReviewBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        btn.setTitle("후기 쓰기", for: .normal)
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
        print("ItemThirdSubController - createReviewBtnDidTap() called")
    }
    
    @objc func buyBtnDidTap() {
        let controller = BuyViewController()
        controller.modalPresentationStyle = .formSheet
        if let off = itemInfo?.off,
            let itemID = itemInfo?.post_id,
            let itemList = itemInfo?.item_list {
            controller.off = off
            controller.postID = itemID
            controller.itemList = itemList
        }
        present(controller, animated: true, completion: nil)
    }
    
    @objc func likeBtnDidTap() {
        print("ItemThirdSubController - likeBtnDidTap() called")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let postID = itemInfo?.post_id else { return }
        ItemManagementManager().getReviews(postID: String(postID)) { result in
            
            switch result {
            case .success(let data):
                debugPrint(data)
                data.result?.forEach {
                    self.reviews.append($0)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
        
        
        
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
        
        view.addSubview(collectionView)
        collectionView.anchor(top: createReviewBtn.bottomAnchor, left: view.leftAnchor,
                              bottom: bottomStack.topAnchor, right: view.rightAnchor)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.identifier)
        collectionView.register(NoReviewCell.self, forCellWithReuseIdentifier: NoReviewCell.identifier)
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
                section.contentInsets.bottom = 8
                
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(100)),
                                                               subitem: item,
                                                               count: 1)
            
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 8
                
                return section
            }
        }
        return layout
    }
    
}


extension ItemThirdSubController: UICollectionViewDelegate {
    
}

extension ItemThirdSubController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if reviews.count == 0 {
                return 1
            } else {
                return reviews.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.identifier,
                                                          for: indexPath) as! ReviewCell
            cell.configureUIForNotification()
            return cell
        } else {
            if reviews.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoReviewCell.identifier,
                                                              for: indexPath) as! NoReviewCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.identifier,
                                                              for: indexPath) as! ReviewCell
                cell.configureUIForReviewCell(reviews[indexPath.item])
                return cell
            }
        }
    }
}

class ReviewCell: UICollectionViewCell {
    
    // Properties
    
    static let identifier: String = String(describing: ReviewCell.self)
    
    private let notificationImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo.artframe")
        iv.tintColor = .black
        iv.setDimensions(height: 15, width: 15)
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.text = " 프렌즈 "
        label.textColor = .mainPurple.withAlphaComponent(0.3)
        label.font = .boldSystemFont(ofSize: 10)
        label.setHeight(15)
        label.layer.cornerRadius = 15 / 2
        label.layer.borderColor = UIColor.mainPurple.withAlphaComponent(0.3).cgColor
        label.layer.borderWidth = 0.5
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray.withAlphaComponent(0.3)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray.withAlphaComponent(0.3)
        label.font = .systemFont(ofSize: 12)
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
    func configureUIForReviewCell(_ review: ReviewResponseResult?) {
        guard let review = review else { return }
        
        addSubview(titleLabel)
        titleLabel.text = review.title
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        addSubview(photoImageView)
        photoImageView.centerY(inView: titleLabel)
        photoImageView.anchor(right: rightAnchor, paddingRight: 16)
        
        addSubview(userNameLabel)
        userNameLabel.text = review.name
        userNameLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        let verticalDivider = UIView()
        verticalDivider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        verticalDivider.setWidth(0.5)
        
        addSubview(verticalDivider)
        verticalDivider.anchor(top: userNameLabel.topAnchor, left: userNameLabel.rightAnchor,
                               bottom: userNameLabel.bottomAnchor, paddingLeft: 10)
        
        addSubview(dateLabel)
        dateLabel.text = review.createDate
        dateLabel.centerY(inView: titleLabel)
        dateLabel.anchor(left: verticalDivider.rightAnchor, paddingLeft: 10)
        
        let horizontalDivider = UIView()
        horizontalDivider.backgroundColor = .lightGray.withAlphaComponent(0.15)
        horizontalDivider.setHeight(0.5)
        
        addSubview(horizontalDivider)
        horizontalDivider.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                                 paddingLeft: 16, paddingRight: 16)
    }
    
    func configureUIForNotification() {
        configureImage()
        addSubview(notificationImageView)
    }
    func configureImage() {
        notificationImageView.image = UIImage(named: "리뷰_공지")
    }
    
}

class NoReviewCell: UICollectionViewCell {
    
    // Properties
    
    static let identifier: String = String(describing: NoReviewCell.self)
    
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "작성된 후기가 없습니다"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .lightGray.withAlphaComponent(0.5)
        return label
    }()
    
    // Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

