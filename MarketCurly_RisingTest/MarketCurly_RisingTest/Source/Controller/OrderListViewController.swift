//
//  OrderListViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/04/01.
//

import UIKit

class OrderListViewController: BaseViewController {
    
    // MARK: - Properties
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return cv
    }()
    
    var orderList: [OrderListResult] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        orderList = []
        ItemManagementManager().getOrderList() { result in
            
            switch(result) {
            case.success(let data):
                data.result?.forEach {
                    self.orderList.append($0)
                }
                self.collectionView.reloadData()
            case.failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
    
    // MARK: - Helpers
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cartViewNoItemCell.self, forCellWithReuseIdentifier: cartViewNoItemCell.identifier)
        collectionView.register(cartViewCollectionViewCell.self, forCellWithReuseIdentifier: cartViewCollectionViewCell.identifier)
    }
    
    
    func configureUI() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
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
            
            return section
        
        }
        return layout
    }
}


extension OrderListViewController: UICollectionViewDelegate {
    
}

extension OrderListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if orderList.count == 0 {
            return 1
        } else {
            return orderList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if orderList.count != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cartViewCollectionViewCell.identifier,
                                                              for: indexPath) as! cartViewCollectionViewCell
            
            cell.configureUI(order: orderList[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cartViewNoItemCell.identifier,
                                                          for: indexPath) as! cartViewNoItemCell
            cell.configureUIForNoOrder()
            return cell
        }
        
    }
}
