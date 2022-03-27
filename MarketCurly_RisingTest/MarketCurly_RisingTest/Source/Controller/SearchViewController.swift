//
//  SearchViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    var filteredCell: [ItemInfoResult] = []
    
    lazy var isSearching: Bool = false
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "검색어를 입력해주세요"
        sb.setImage(nil, for: .search, state: .normal)
        return sb
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
        btn.addTarget(self, action: #selector(cartBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var locationBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "location"), for: .normal)
        return btn
    }()
    
    // MARK: - Action
    @objc func cartBtnDidTap() {
        if Constant.USER_INDEX < 0 {
            let controller = LoginViewController()
            controller.loginDelegate = self
            
            let nav = UINavigationController(rootViewController: controller)
            nav.navigationBar.isHidden = true
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } else {
            let controller = CartViewController()
            
            let nav = UINavigationController(rootViewController: controller)
            nav.navigationBar.isHidden = true
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        configureNavigationBar()
        configureSearchBar()
        configureCollectionView()
        
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor,
                              bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: -5)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemInfoCell.self, forCellWithReuseIdentifier: ItemInfoCell.identifier)
        collectionView.register(collectionViewCellBeforeSearch.self, forCellWithReuseIdentifier: collectionViewCellBeforeSearch.identifier)
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
    
    func configureSearchBar() {
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        containerView.setHeight(50)
        
        
        containerView.addSubview(searchBar)
        searchBar.fillSuperview()
        searchBar.delegate = self
    }
    
    func configureNavigationBar() {
        
        let stack = UIStackView(arrangedSubviews: [locationBtn, cartBtn])
        stack.spacing = 10
            
        navigationItem.title = "검색"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stack)
        
    }
}


extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.RECOMMENDED_ITEM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInfoCell.identifier,
//                                                      for: indexPath) as! ItemInfoCell
//        cell.setTitle("상품 이름\(indexPath.item)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellBeforeSearch.identifier,
                                                    for: indexPath) as! collectionViewCellBeforeSearch
        cell.configureBtnText(Constant.RECOMMENDED_ITEM[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: ItemCountHeader.identifier,
                                                                     for: indexPath) as! ItemCountHeader
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        pushItemDetailViewController(withItem: filteredCell[indexPath.item]) // 셀 이름 정하고 만들어야함
    }
    
    func pushItemDetailViewController(withItemName: String) {
        let controller = ItemDetailViewController()
        controller.navigationItem.title = withItemName
        navigationController?.pushViewController(controller, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let len = Constant.RECOMMENDED_ITEM[indexPath.item].count
//        let width = len * 10
//        let height = 20
//        let size = CGSize(width: width, height: height)
//        return size
//    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchBar.setShowsCancelButton(true, animated: true)  //애니메이션 주면 취소버튼이 파란색으로 변함
        searchBar.showsCancelButton = true
        if let cancelBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelBtn.setTitleColor(.black, for: .normal)
            cancelBtn.setTitle("취소 ", for: .normal)
        }
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("검색")
    }
}



// MARK: - collectionViewCellBeforeSearch
class collectionViewCellBeforeSearch: UICollectionViewCell {
    
    // Properties
    static let identifier: String = String(describing: collectionViewCellBeforeSearch.self)
    
    private let cellBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .mainPurple.withAlphaComponent(0.3)
        btn.setTitleColor(.mainPurple, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 10)
        btn.setHeight(20)
        btn.layer.cornerRadius = 20 / 2
        btn.addTarget(self, action: #selector(cellBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    // Action
    @objc func cellBtnDidTap() {
        print("collectionViewCellBeforeSearch - cellBtnDidTap()")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(cellBtn)
        cellBtn.centerX(inView: self)
        cellBtn.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Helper
    func configureBtnText(_ text: String) {
        cellBtn.setTitle("" + text + "", for: .normal)
    }
}


extension SearchViewController: LoginViewControllerDelegate {
    func userLoggedIn() {
        
    }
}
