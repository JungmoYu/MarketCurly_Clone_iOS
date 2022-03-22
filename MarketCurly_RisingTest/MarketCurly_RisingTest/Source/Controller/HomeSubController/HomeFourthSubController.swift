//
//  HomeFourthSubController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class HomeFourthSubController: BaseViewController {
    
    // MARK: - Properties
    
    private let adString: String = "알뜰쇼핑"
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        cv.backgroundColor = .white
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
    }
    
    // MARK: - Helpers
    
    
    func configureUI() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeViewAdCell.self, forCellWithReuseIdentifier: HomeViewAdCell.identifier)
        collectionView.register(ItemInfoCell.self, forCellWithReuseIdentifier: ItemInfoCell.identifier)
        collectionView.register(ItemCountHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ItemCountHeader.identifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
        
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .fractionalWidth(1.15)),
                                                               subitem: item,
                                                               count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            } else {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension:.absolute(330)),
                                                               subitem: item,
                                                               count: 2)
                group.contentInsets.bottom = 12
                group.interItemSpacing = .fixed(8)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 16
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                            heightDimension: .absolute(30)),
                          elementKind: UICollectionView.elementKindSectionHeader,
                          alignment: .top)
                    ]
                
                return section
            }
        }
        return layout
    }
    
}



extension HomeFourthSubController: UICollectionViewDelegate {
    
}

extension HomeFourthSubController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 50
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeViewAdCell.identifier, for: indexPath) as! HomeViewAdCell
            
            cell.configureAdImage(for: adString)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ItemInfoCell.identifier, for: indexPath) as! ItemInfoCell
            cell.setTitle("상품 이름\(indexPath.item)")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: ItemCountHeader.identifier, for: indexPath) as! ItemCountHeader
            
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ItemInfoCell
        pushItemDetailViewController(withItemName: cell.getTitle())
    }
    
    func pushItemDetailViewController(withItemName: String) {
        let controller = ItemDetailViewController()
        controller.navigationItem.title = withItemName
        navigationController?.pushViewController(controller, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
}
