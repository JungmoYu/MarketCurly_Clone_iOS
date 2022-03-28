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
        if let off = itemInfo?.off, let itemID = itemInfo?.post_id {
            controller.off = off
            controller.itemID = itemID
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
        collectionView.register(ItemInfoCell.self, forCellWithReuseIdentifier: ItemInfoCell.identifier)
        collectionView.register(ItemDetailViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ItemDetailViewHeader.identifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .fractionalHeight(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalWidth(0.9)),
                                                           subitem: item,
                                                           count: 1)
        
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.bottom = 8
            section.orthogonalScrollingBehavior = .groupPaging
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                    heightDimension: .absolute(250)),
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            section.boundarySupplementaryItems.append(header)
            
            return section
        }
        return layout
    }
    
}


extension ItemThirdSubController: UICollectionViewDelegate {
    
}

extension ItemThirdSubController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInfoCell.identifier, for: indexPath) as! ItemInfoCell
        cell.viewController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ItemDetailViewHeader.identifier,
                                                                     for: indexPath) as! ItemDetailViewHeader
        return header
    }
}
