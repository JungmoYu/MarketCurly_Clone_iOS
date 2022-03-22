//
//  HomeFifthSubController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class HomeFifthSubController: BaseViewController {
    
    // MARK: - Properties
    
    private let adStringArray: [String] = ["특가1", "특가2", "특가3", "특가4", "특가5", "특가6", "특가7", "특가8", "특가9", "특가10",
                                           "특가11", "특가12","특가13", "특가14", "특가15", "특가16", "특가17", "특가18", "특가19", "특가20"]
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        cv.backgroundColor = .white
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .fractionalHeight(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .absolute(160)),
                                                           subitem: item,
                                                           count: 1)
            
            group.contentInsets.bottom = 16
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
    
}


extension HomeFifthSubController: UICollectionViewDelegate {
    
}

extension HomeFifthSubController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adStringArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeViewAdCell.identifier, for: indexPath) as! HomeViewAdCell
        
        cell.configureAdImage(for: adStringArray[indexPath.item])
        return cell
    }
    
    
    
    
}
