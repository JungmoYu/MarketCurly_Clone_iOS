//
//  HomeThirdSubController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class HomeThirdSubController: BaseViewController {
    
    // MARK: - Properties
    
    private var bestItemCell: [ItemInfoResult] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bestItemCell = []
        getBestItem()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemInfoCell.self, forCellWithReuseIdentifier: ItemInfoCell.identifier)
        collectionView.register(ItemCountHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ItemCountHeader.identifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
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
        return layout
    }
    
    private func getBestItem() {
        ItemManagementManager().getRandomItem { result in
            switch result {
            case .success(let data):
                data.result?.forEach {
                    self.bestItemCell.append($0)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print("g2?")
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
    
}


extension HomeThirdSubController: UICollectionViewDelegate {
    
}

extension HomeThirdSubController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestItemCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ItemInfoCell.identifier, for: indexPath) as! ItemInfoCell
        cell.configureCell(bestItemCell[indexPath.item], isDailyPrice: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: ItemCountHeader.identifier, for: indexPath) as! ItemCountHeader
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushItemDetailViewController(withItem: bestItemCell[indexPath.item])
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
