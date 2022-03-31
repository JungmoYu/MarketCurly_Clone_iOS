//
//  ItemSecondSubController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/22.
//

import UIKit

class ItemSecondSubController: BaseViewController {
    
    // MARK: - Properties
    
    var itemInfo: ItemInfoResult?
    private let imageArr = ["상세정보_정보", "상세정보_행복센터", "상세정보_문의"]
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return cv
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
        print("ItemSecondSubController - likeBtnDidTap() called")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        let bottomStack = UIStackView(arrangedSubviews: [likeBtn, buyBtn])
        bottomStack.spacing = 10
        bottomStack.distribution = .fill
        
        view.addSubview(bottomStack)
        bottomStack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                           paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: bottomStack.topAnchor, right: view.rightAnchor)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SecondSubControllerCell.self, forCellWithReuseIdentifier: SecondSubControllerCell.identifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(350)),
                                                               subitem: item,
                                                               count: 1)
            
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 10
                return section
            } else if sectionIndex == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(750)),
                                                               subitem: item,
                                                               count: 1)
            
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 10
                return section
                
            } else if sectionIndex == 2 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(500)),
                                                               subitem: item,
                                                               count: 1)
            
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .absolute(300)),
                                                               subitem: item,
                                                               count: 1)
            
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            }
            
        }
        return layout
    }
    
}


extension ItemSecondSubController: UICollectionViewDelegate {
    
}

extension ItemSecondSubController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondSubControllerCell.identifier,
                                                      for: indexPath) as! SecondSubControllerCell
        if indexPath.section == 0 {
            guard let imgStr = itemInfo?.image else { return UICollectionViewCell()}
            cell.configureImgeWithString(imgStr, isURL: true)
        } else {
            cell.configureImgeWithString(imageArr[indexPath.section - 1], isURL: false)
        }
        return cell
    }
    
}

class SecondSubControllerCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: SecondSubControllerCell.self)
    
    // Properties
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = . scaleToFill
        return iv
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
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    func configureImgeWithString(_ imgStr: String, isURL: Bool) {
        
        if isURL {
            let url = URL(string: imgStr)
            imageView.load(url: url!)
        } else {
            imageView.image = UIImage(named: imgStr)
        }
        configureUI()
    }
}
