//
//  JoinViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/21.
//

import UIKit


class JoinViewController: BaseViewController {
    
    // MARK: - Properties
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        cv.backgroundColor = .lightGray.withAlphaComponent(0.15)
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
//        UINavigationBar.appearance().barTintColor = .white
//        UINavigationBar.appearance().backgroundColor = .white
//        UINavigationBar.appearance().tintColor = .black
//
//        navigationController?.setNeedsStatusBarAppearanceUpdate()
//
        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.backgroundColor = .white
        
        navigationItem.title = "회원가입"
        
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        
        configureCollectionView()
        self.dismissKeyboardWhenTappedAround()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(JoinViewCell.self, forCellWithReuseIdentifier: JoinViewCell.identifier)
        collectionView.register(JoinViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: JoinViewFooter.identifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
           
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .fractionalHeight(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension:.absolute(750)),
                                                           subitem: item,
                                                           count: 1)
    
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.bottom = 12
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                        heightDimension: .absolute(600)),
                      elementKind: UICollectionView.elementKindSectionFooter,
                      alignment: .bottom)
            ]
            
            return section

        }
        return layout
    }
    
    
}

extension JoinViewController: UICollectionViewDelegate {
    
}

extension JoinViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JoinViewCell.identifier, for: indexPath) as! JoinViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: JoinViewFooter.identifier,
                                                                     for: indexPath) as! JoinViewFooter
        footer.delegate = self
        return footer
    }
    
}


extension JoinViewController: JoinViewFooterDelegate {
    func requestJoin() {
        // 여기서 버튼 정보들 가져와야함(뭐를 동의했고 뭐를 동의하지 않았는지?)
        // 네트워크로 회원가입 요청 구현 예정
        navigationController?.popViewController(animated: true)
    }
    
    
}
