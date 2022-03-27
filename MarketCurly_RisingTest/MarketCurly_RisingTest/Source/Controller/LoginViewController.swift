//
//  LoginViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/20.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func userLoggedIn(_ with: UserResponseResult)
}

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    weak var loginDelegate: LoginViewControllerDelegate?
    weak var viewController: UIViewController?
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("𝖷", for: .normal)
        btn.tintColor = .black
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(cancelBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private let idTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "아이디를 입력해주세요")
        tf.layer.cornerRadius = 3
        return tf
    }()
    
    private let passwordTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "비밀번호를 입력해주세요")
        tf.layer.cornerRadius = 3
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .mainPurple
        btn.setTitle("로그인", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var joinButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(.mainPurple, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        btn.layer.borderColor = UIColor.mainPurple.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(joinButtonDidTap), for: .touchUpInside)
        return btn
    }()
    
    private let findInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디 찾기 | 비밀번호 찾기"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Actions
    
    @objc func cancelBtnDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func loginButtonDidTap() {
        
        
        let userRequest = LoginUserRequest(id: idTextField.text ?? "",
                                           password: passwordTextField.text ?? "")
        if userRequest.id == "" {
            presentAlert(title: "ID를 입력해주세요")
        } else if userRequest.password == "" {
            presentAlert(title: "비밀번호를 입력해주세요")
        } else {
            UserManagementManager().loninRequest(userRequest) { result in
                switch result {
                case .success(let data):
                    if data.isSuccess {
                        Constant.USER_INDEX = data.result?.userIdx ?? Int(-1)
                        Constant.JWT = data.result?.jwt ?? ""
                        print(Constant.USER_INDEX)
                        UserManagementManager().searchUser(userID: Constant.USER_INDEX, JWT: Constant.JWT) { response in
                            
                            switch response {
                            case .success(let data):
                                if data.isSuccess {
                                    Constant.User = data.result?[0]
                                    self.loginDelegate?.userLoggedIn((data.result?[0])!)
                                    self.dismiss(animated: true, completion: nil)
                                }
                            case .failure(let error):
                                print("여기..?")
                                print(error.localizedDescription)
                            }
                        }
                    } else {
                        self.presentAlert(title: "로그인 실패", message: data.message)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @objc func joinButtonDidTap() {
        print("LoginViewController - joinButtonDidTap() called")
        let controller = JoinViewController()
        navigationController?.pushViewController(controller, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        idTextField.text = ""
        passwordTextField.text = ""
    }
    // MARK: - Helpers
    
    func configureUI() {
    
        view.addSubview(cancelBtn)
        cancelBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingLeft: 16)
        
        view.addSubview(loginLabel)
        loginLabel.centerX(inView: view)
        loginLabel.centerY(inView: cancelBtn)
        
        view.addSubview(idTextField)
        idTextField.anchor(top: loginLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                           paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(passwordTextField)
        passwordTextField.anchor(top: idTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                 paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: passwordTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                           paddingTop: 18, paddingLeft: 16, paddingRight: 16)
        loginButton.setHeight(50)
        
        view.addSubview(findInfoLabel)
        findInfoLabel.anchor(top: loginButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                             paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(joinButton)
        joinButton.anchor(top: findInfoLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                          paddingTop: 30, paddingLeft: 16, paddingRight: 16)
        joinButton.setHeight(50)
        
        self.dismissKeyboardWhenTappedAround()
    }
    
}
