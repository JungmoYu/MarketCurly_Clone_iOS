//
//  CreateReviewViewController.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/30.
//

import UIKit


class CreateReviewViewController: BaseViewController {
    
    
    // MARK: - Properties
    
    var isUpdating: Bool = false
    var post: ItemInfoResult?
    var reviewID: String = ""
    
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
            navigationItem.title = "후기 수정"
        } else {
            navigationItem.title = "후기 작성"
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
        collectionView.register(CreateReviewCell.self, forCellWithReuseIdentifier: CreateReviewCell.identifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            
           
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .fractionalHeight(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension:.absolute(700)),
                                                           subitem: item,
                                                           count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
    
}

extension CreateReviewViewController: UICollectionViewDelegate {
    
}

extension CreateReviewViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreateReviewCell.identifier,
                                                      for: indexPath) as! CreateReviewCell
        if let itemID = post?.item_list[0].item_id {
            cell.itemID = itemID
            cell.reviewID = reviewID
            cell.configureUI(post!, isUpdating: isUpdating)
            cell.viewController = self
            cell.delegate = self
            return cell
        } else { return UICollectionViewCell() }
        
    }

}


extension CreateReviewViewController: CreateReviewCellDelegate {
    func requestDeleteReview(reviewID: String) {
        ItemManagementManager().deleteReview(reviewID: reviewID) { result in
            switch result {
            case .success(let data):
                if data.isSuccess {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.presentAlert(title: "후기 삭제 실패", message: data.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
    
    func requestReview(_ review: ReviewRequest) {
        ItemManagementManager().createReview(review: review) { result in
            switch result {
            case .success(let data):
                if data.isSuccess {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.presentAlert(title: "후기 작성 실패", message: data.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
    
    func requestUpdateReview(reviewID: String, review: ReviewRequest) {
        ItemManagementManager().updateReview(reviewID: reviewID, review: review) { result in
            switch result {
            case .success(let data):
                if data.isSuccess {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.presentAlert(title: "후기 수정 실패", message: data.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            IndicatorView.shared.dismiss()
        }
    }
    
}





// MARK: - CreateReviewCell

protocol CreateReviewCellDelegate: AnyObject {
    func requestReview(_ review: ReviewRequest)
    func requestUpdateReview(reviewID: String, review: ReviewRequest)
    func requestDeleteReview(reviewID: String)
}

class CreateReviewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: CreateReviewCell.self)
    var itemID:Int = 0
    var reviewID: String = ""
    var controller: UIViewController?
    weak var delegate: CreateReviewCellDelegate?
    weak var viewController: UIViewController?
    
    
    private lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .mainPurple
        return label
    }()
    
    private lazy var reviewTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText(text: "후기 제목")
        return label
    }()
    
    private lazy var reviewContentLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText(text: "후기 내용")
        return label
    }()
    
    private let reviewTitleTextField: BaseTextField = {
        let tf = BaseTextField(placeholder: "예 : 너무 맛있는 딸기 추천해요~!")
        tf.layer.cornerRadius = 3
        return tf
    }()
    
    private let reviewContetnTextField: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.cornerRadius = 3
        return tv
    }()
    
    private lazy var createReviewBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setHeight(50)
        btn.backgroundColor = .mainPurple
        btn.setTitle("후기작성 완료", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(createReviewBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var updateReviewBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setHeight(50)
        btn.backgroundColor = .mainPurple
        btn.setTitle("수정하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(updateBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var deleteReviewBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setHeight(50)
        btn.backgroundColor = .systemRed
        btn.setTitle("삭제하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(deleteBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Actions

    @objc func dismissKeyboard() {
        endEditing(false)
    }
    
    @objc func createReviewBtnDidTap() {
        
        let review = ReviewRequest(item_id: itemID,
                                   title: reviewTitleTextField.text ?? "",
                                   content: reviewContetnTextField.text ?? "")
        
        if reviewTitleTextField.text == "" {
            viewController?.presentAlert(title: "후기 제목을 입력해주세요")
        } else {
            delegate?.requestReview(review)
        }
        
    }
    
    
    @objc func updateBtnDidTap() {
        let review = ReviewRequest(item_id: itemID,
                                   title: reviewTitleTextField.text ?? "",
                                   content: reviewContetnTextField.text ?? "")
        delegate?.requestUpdateReview(reviewID: reviewID, review: review)

    }
    
    @objc func deleteBtnDidTap() {
        viewController?.presentAlert(title: "리뷰 삭제", message: "정말로 삭제하시겠습니까?", isCancelActionIncluded: true) { isYes in
            self.delegate?.requestDeleteReview(reviewID: self.reviewID)
        }
    }

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func attributedText(text: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "*", attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                           .foregroundColor: UIColor.red]))
        return attributedText
    }
    
    func configureUI(_ item: ItemInfoResult, isUpdating: Bool) {
        
        addSubview(itemTitleLabel)
        itemTitleLabel.anchor(top: topAnchor, left: leftAnchor,paddingTop: 16, paddingLeft: 16)
        itemTitleLabel.text = item.title
        
        addSubview(reviewTitleLabel)
        reviewTitleLabel.anchor(top: itemTitleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                       paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        addSubview(reviewTitleTextField)
        reviewTitleTextField.anchor(top: reviewTitleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                             paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        addSubview(reviewContentLabel)
        reviewContentLabel.anchor(top: reviewTitleTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                 paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        addSubview(reviewContetnTextField)
        reviewContetnTextField.setHeight(400)
        reviewContetnTextField.anchor(top: reviewContentLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                             paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        if isUpdating {
            createReviewBtn.removeFromSuperview()
            
            addSubview(deleteReviewBtn)
            deleteReviewBtn.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor,
                                   paddingLeft: 16, paddingRight: 16)
            
            addSubview(updateReviewBtn)
            updateReviewBtn.anchor(left: leftAnchor, bottom: deleteReviewBtn.topAnchor, right: rightAnchor,
                                    paddingLeft: 16, paddingBottom: 10, paddingRight: 16)
            
            
        } else {
            updateReviewBtn.removeFromSuperview()
            deleteReviewBtn.removeFromSuperview()
            addSubview(createReviewBtn)
            createReviewBtn.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor,
                           paddingLeft: 16, paddingBottom: 10, paddingRight: 16)
        }
        
        
        
    }
    
    // MARK: 빈 화면을 눌렀을 때 키보드가 내려가도록 처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    //        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
}

