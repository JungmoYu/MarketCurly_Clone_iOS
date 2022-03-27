//
//  ProfileViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var isLogin: Bool = false
    private var user: UserResponseResult?
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        cv.backgroundColor = .lightGray.withAlphaComponent(0.15)
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
        configureUI()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionView.collectionViewLayout.invalidateLayout()
//    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureNavigationBar()
        configureCollectionView()
        
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    func configureNavigationBar() {
        
        let stack = UIStackView(arrangedSubviews: [locationBtn, cartBtn])
        stack.spacing = 10
            
        navigationItem.title = "마이컬리"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stack)
        
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileViewCell.self, forCellWithReuseIdentifier: ProfileViewCell.identifier)
        collectionView.register(ProfileViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileViewHeader.identifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        var headerHeight: CGFloat = 0
        
        if self.isLogin {
            headerHeight = CGFloat(Constant.PROFILE_HEADER_LOGGED_IN)
        } else {
            headerHeight = CGFloat(Constant.PROFILE_HEADER_LOGGED_OUT)
        }
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension:.absolute(50)),
                                                               subitem: item,
                                                               count: 1)
        
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 12
                
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                            heightDimension: .absolute(headerHeight)),
                          elementKind: UICollectionView.elementKindSectionHeader,
                          alignment: .top)
                ]
                return section
                
            } else {
                
            }
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .fractionalHeight(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension:.absolute(50)),
                                                           subitem: item,
                                                           count: 1)
    
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 12
            
            return section
        }
        return layout
    }
    
}


extension ProfileViewController: UICollectionViewDelegate {
    
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if isLogin {
            return Constant.CELL_DATA_LOGGED_IN.count
        } else {
            return Constant.CELL_DATA_LOGGED_OUT.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLogin {
            return Constant.CELL_DATA_LOGGED_IN[section].sectionData.count
        } else {
            return Constant.CELL_DATA_LOGGED_OUT[section].sectionData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileViewCell.identifier, for: indexPath) as! ProfileViewCell
    
        if isLogin {
            cell.configureMenuLabelText(withText: Constant.CELL_DATA_LOGGED_IN[indexPath.section].sectionData[indexPath.item])
        } else {
            cell.configureMenuLabelText(withText: Constant.CELL_DATA_LOGGED_OUT[indexPath.section].sectionData[indexPath.item])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: ProfileViewHeader.identifier, for: indexPath) as! ProfileViewHeader
        header.configureUI(isLoggedIn: isLogin, userName: user?.name ?? "")
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isLogin {
            if (indexPath.section == Constant.CELL_DATA_LOGGED_IN.count - 1)
                && (indexPath.item == Constant.CELL_DATA_LOGGED_IN[indexPath.section].sectionData.count - 1) {
                
                isLogin = false
                user = nil
                self.presentAlert(title: "로그아웃 되었습니다.")
                collectionView.reloadData()
            }
            
            if (indexPath.section == Constant.CELL_DATA_LOGGED_IN.count - 4)
                && (indexPath.item == Constant.CELL_DATA_LOGGED_IN[indexPath.section].sectionData.count - 2) {
                let controller = JoinViewController()
                controller.isUpdating = true
                navigationController?.pushViewController(controller, animated: true)
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            }
        }
        
    }
    
    
}

extension ProfileViewController: ProfileViewHeaderDelegate {
    func popupLoginViewController() {
        let controller = LoginViewController()
//        controller.modalPresentationStyle = .fullScreen
        controller.loginDelegate = self
        
        let nav = UINavigationController(rootViewController: controller)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
}

extension ProfileViewController: LoginViewControllerDelegate {
    
    func userLoggedIn(_ user: UserResponseResult) {
        self.user = user
        isLogin = true
        collectionView.reloadData()
//        UserManagementManager().loninRequest(with) { result in
//            switch result {
//            case .success(let data):
//                if data.isSuccess {
//                    Constant.USER_INDEX = data.result?.userIdx ?? Int(-1)
//                    Constant.JWT = data.result?.jwt ?? ""
//
//
//                    UserManagementManager().searchUser(userID: Constant.USER_INDEX, JWT: Constant.JWT) { response in
//                        switch response {
//                        case .success(let data):
//                            if data.isSuccess {
//                                self.user = data.result?[0]
//                            }
//                            self.isLogin = true
//                            self.collectionView.reloadData()
//                        case .failure(let error):
//                            print(error.localizedDescription)
//                        }
//                    }
//
//
//                } else {
//                    self.presentAlert(title: "로그인 실패", message: data.message)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//
//
//        }
        
    }
    
}
