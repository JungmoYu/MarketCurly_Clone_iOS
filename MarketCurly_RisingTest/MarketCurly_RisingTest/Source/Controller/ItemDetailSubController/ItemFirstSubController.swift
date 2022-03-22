//
//  ItemFirstSubController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/22.
//

import UIKit

class ItemFirstSubController: BaseViewController {
    
    // MARK: - Properties
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return cv
    }()
    
    var itemInfo: String = "" // 나중에 여기 아이템 모델이 와야함(전달하는 뷰컨트롤러에서 넘겨줘야하고)
    
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
        print("ItemFirstSubController - buyBtnDidTap() called")
    }
    
    @objc func likeBtnDidTap() {
        print("ItemFirstSubController - likeBtnDidTap() called")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
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
        collectionView.register(ItemDetailViewCell.self, forCellWithReuseIdentifier: ItemDetailViewCell.identifier)
        collectionView.register(ItemDetailViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ItemDetailViewHeader.identifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .fractionalHeight(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .absolute(200)),
                                                           subitem: item,
                                                           count: 1)
        
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.bottom = 8
            section.orthogonalScrollingBehavior = .groupPaging
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                    heightDimension: .absolute(750)),
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            section.boundarySupplementaryItems.append(header)
            
            return section
        }
        return layout
    }
    
}


extension ItemFirstSubController: UICollectionViewDelegate {
    
}

extension ItemFirstSubController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemDetailViewCell.identifier, for: indexPath) as! ItemDetailViewCell
        cell.configureText()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ItemDetailViewHeader.identifier,
                                                                     for: indexPath) as! ItemDetailViewHeader
        // 모델로 넘겨줘야함
        header.configureAdImage(for: "상품예시")
        header.configureNameLabel(itemInfo)
        header.configureDescriptionLabel("영원한 동반자 \(itemInfo)")
        header.configureMemberPriceLabel("2961원")
        header.configureDiscountRateLabel("10%")
        header.configureOriginalPriceLabel("3290원")
        header.configureDiscountRateLabel("10%")
        header.configurePointLabel("0.5%", isMember: false)
        return header
    }
}


