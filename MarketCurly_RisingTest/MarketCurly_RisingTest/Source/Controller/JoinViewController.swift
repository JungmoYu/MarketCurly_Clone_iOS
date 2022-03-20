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
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
           
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .fractionalHeight(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension:.fractionalHeight(0.9)),
                                                           subitem: item,
                                                           count: 1)
    
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 12
            
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
    
    
}
