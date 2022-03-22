//
//  SearchViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        cv.backgroundColor = .darkGray
        return cv
    }()
    
    private let titleImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo_white")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var cartBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "cart"), for: .normal)
        return btn
    }()
    
    private lazy var locationBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "location"), for: .normal)
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        configureNavigationBar()
        configureSearchController()
        configureCollectionView()
        
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        containerView.setHeight(80)
        containerView.backgroundColor = .red
        containerView.addSubview(searchController.searchBar)
        
//        view.addSubview(searchController.searchBar)
//        searchController.searchBar.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
//        searchController.searchBar.setHeight(80)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: searchController.searchBar.bottomAnchor, left: view.leftAnchor,
                              bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemInfoCell.self, forCellWithReuseIdentifier: ItemInfoCell.identifier)
        collectionView.register(ItemListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ItemListHeader.identifier)
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
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "검색어를 입력해주세요"
    }
    
    func configureNavigationBar() {
        
        let stack = UIStackView(arrangedSubviews: [locationBtn, cartBtn])
        stack.spacing = 10
            
        navigationItem.title = "검색"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stack)
        
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        print(searchText)
        collectionView.reloadData()
    }

}


extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInfoCell.identifier,
                                                      for: indexPath) as! ItemInfoCell
        cell.setTitle("상품 이름\(indexPath.item)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: ItemCountHeader.identifier,
                                                                     for: indexPath) as! ItemCountHeader
        return header
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
