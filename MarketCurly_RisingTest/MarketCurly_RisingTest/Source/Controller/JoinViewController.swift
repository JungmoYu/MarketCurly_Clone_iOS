//
//  JoinViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/21.
//

import UIKit


class JoinViewController: BaseViewController {
    
    // MARK: - Properties
    
    var isUpdating: Bool = false
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
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
        navigationController?.navigationBar.tintColor = .white
        
        if isUpdating {
            navigationItem.title = "회원정보 수정"
        } else {
            navigationItem.title = "회원가입"
        }

        
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
            
            let groupUpdating = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension:.absolute(700)),
                                                           subitem: item,
                                                           count: 1)

            let groupJoin = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension:.absolute(1350)),
                                                           subitem: item,
                                                           count: 1)
            
            let sectionUpdating = NSCollectionLayoutSection(group: groupUpdating)
            sectionUpdating.contentInsets.bottom = 12
            let sectionJoin = NSCollectionLayoutSection(group: groupJoin)
            sectionJoin.contentInsets.bottom = 12
            
            if self.isUpdating {
                return sectionUpdating
            } else {
                return sectionJoin
            }
            

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
        cell.configureUI(isUpdating: isUpdating)
        cell.viewController = self
        cell.delegate = self
        return cell
    }

}


extension JoinViewController: JoinViewCellDelegate {
    func requestUpdate(_ userInfo: UpdateUserRequest) {
        
        UserManagementManager().updateRequest(userInfo) { result in
            switch result {
            case .success(let data):
                if data.isSuccess {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.presentAlert(title: "정보수정 실패", message: data.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func requestJoin(_ userInfo: JoinUserRequest) {
        
        UserManagementManager().joinRequest(userInfo) { result in
            switch result {
            case .success(let data):
                if data.isSuccess {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.presentAlert(title: "회원가입 실패", message: data.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}
