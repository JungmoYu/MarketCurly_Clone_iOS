//
//  HomeFirstViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class HomeFirstViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var bannerTimer: Timer?
    private var isBannerTimerRunning: Bool = false
    private var currentPage: Int = 0
    var randomCell: [ItemInfoResult] = []
    var dailyCell: [ItemInfoResult] = []
    var recommendedCell: [ItemInfoResult] = []

    private let adImageStringArray = ["광고1", "광고2", "광고3", "광고4", "광고5", "광고6",
                                      "광고7", "광고8", "광고9", "광고10", "광고11", "광고12"]
    private let adImageStringForFooterArray = ["하단광고1", "하단광고3", "하단광고3"]

    lazy var collectionView: UICollectionView = {
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
        
        clearItems()
        getItemsFromAPI()
        makeAndFireTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        invalidateTimer()
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
        collectionView.register(ItemListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ItemListHeader.identifier)
        collectionView.register(ItemListFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: ItemListFooter.identifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .fractionalWidth(0.9)),
                                                               subitem: item,
                                                               count: 1)
            
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 8
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
            } else if sectionIndex == 1 {
                return self.createCommonSection(hasHeader: true, hasFooter: true)
            } else if sectionIndex == 2 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension:.absolute(300)),
                                                               subitem: item,
                                                               count: 1)
                group.contentInsets.leading = 16
                group.contentInsets.trailing = 16
                group.interItemSpacing = .fixed(8)
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.top = 8
                section.contentInsets.bottom = 8
                
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                            heightDimension: .absolute(110)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                section.boundarySupplementaryItems.append(header)
                return section
            } else {
                return self.createCommonSection(hasHeader: true, hasFooter: false)
            }
            
        }
        return layout
    }
    
    func createCommonSection(hasHeader: Bool, hasFooter: Bool) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(4),
                                                                         heightDimension:.absolute(260)),
                                                       subitem: item,
                                                       count: 10)
        group.contentInsets.leading = 16
        group.contentInsets.trailing = 16
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets.top = 8
        section.contentInsets.bottom = 8
        
        if hasHeader {
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                    heightDimension: .absolute(50)),
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            section.boundarySupplementaryItems.append(header)
        }
        
        if hasFooter {
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                      heightDimension: .absolute(80)),
                                                                     elementKind: UICollectionView.elementKindSectionFooter,
                                                                       alignment: .bottom)
            section.boundarySupplementaryItems.append(footer)
        }
        
        return section
    }
    
    private func clearItems() {
        dailyCell = []
        recommendedCell = []
        randomCell = []
    }
    
    private func getItemsFromAPI() {
        getRandomItem()
    }
    
    private func getRandomItem() {
        ItemManagementManager().getRandomItem { result in
            switch result {
            case .success(let data):
                data.result?.forEach {
                    self.randomCell.append($0)
                }
                self.getDealItem()
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
    
    private func getDealItem() {
        ItemManagementManager().getDealItem { result in
            switch result {
            case .success(let data):
                data.result?.forEach {
                    self.dailyCell.append($0)
                }
                self.getRecommendedItem()
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
    
    private func getRecommendedItem() {
        ItemManagementManager().getRecommendedItem { result in
            switch result {
            case .success(let data):
                data.result?.forEach {
                    self.recommendedCell.append($0)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
    
    func makeAndFireTimer() {
        isBannerTimerRunning = true
        DispatchQueue.global().async {
            let runLoop = RunLoop.current
            self.bannerTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { Timer in
                DispatchQueue.main.async {
                    self.moveBannerAd()
                }
            }
            while self.isBannerTimerRunning {
                    runLoop.run(until: Date().addingTimeInterval(0.1))
                }
        }
        
    }
    
    func invalidateTimer() {
        isBannerTimerRunning = false
        bannerTimer?.invalidate()
    }
    
    func moveBannerAd() {
        if currentPage == adImageStringArray.count - 1 {
            collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            currentPage = 0
            return
        }
        currentPage += 1
        collectionView.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .centeredHorizontally, animated: true)
        
    }
}

extension HomeFirstViewController: UICollectionViewDelegate {
//    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//    }
}

extension HomeFirstViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return adImageStringArray.count
        case 1:
            return randomCell.count
        case 2:
            return 1
        case 3:
            return recommendedCell.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeViewAdCell.identifier, for: indexPath) as! HomeViewAdCell
            cell.configureAdImage(for: adImageStringArray[indexPath.item])
            currentPage = indexPath.item
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInfoCell.identifier, for: indexPath) as! ItemInfoCell
            cell.configureCell(randomCell[indexPath.item], isDailyPrice: false)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInfoCell.identifier, for: indexPath) as! ItemInfoCell
            cell.configureCell(dailyCell[0], isDailyPrice: true)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInfoCell.identifier, for: indexPath) as! ItemInfoCell
            cell.configureCell(recommendedCell[indexPath.item], isDailyPrice: false)
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 1:
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: ItemListHeader.identifier, for: indexPath) as! ItemListHeader
                return header
            } else {
                let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: ItemListFooter.identifier, for: indexPath) as! ItemListFooter
                footer.configureAdImage(item: adImageStringForFooterArray[Int.random(in: 0...2)])
                return footer
            }
        case 2:
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: ItemListHeader.identifier, for: indexPath) as! ItemListHeader
                header.configureCell(isDailyPrice: true)
                return header
            } else {
                let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: ItemListFooter.identifier, for: indexPath) as! ItemListFooter
                footer.configureAdImage(item: adImageStringForFooterArray[Int.random(in: 0...2)])
                return footer
            }
        case 3:
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: ItemListHeader.identifier, for: indexPath) as! ItemListHeader
                return header
            } else {
                let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: ItemListFooter.identifier, for: indexPath) as! ItemListFooter
                footer.configureAdImage(item: adImageStringForFooterArray[Int.random(in: 0...2)])
                return footer
            }
        default:
            return UICollectionReusableView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 { return }
        switch indexPath.section {
        case 1:
            pushItemDetailViewController(withItem: randomCell[indexPath.item])
        case 2:
            pushItemDetailViewController(withItem: dailyCell[indexPath.item])
        case 3:
            pushItemDetailViewController(withItem: recommendedCell[indexPath.item])
        default:
            return
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
