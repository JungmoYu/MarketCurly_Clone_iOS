//
//  ItemDetailViewCell.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/23.
//

import UIKit

class ItemDetailViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: ItemDetailViewCell.self)
    
    private let itemInfoTextLabel: UILabel = {
        let label = UILabel()
        label.text = "상품정보"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let unitTextLabel: UILabel = {
        let label = UILabel()
        label.text = "판매단위"
        label.textColor = .black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let unitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let volumeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "중량/용량"
        label.textColor = .black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let shiptypeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "배송구분"
        label.textColor = .black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let shiptypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let originTextLabel: UILabel = {
        let label = UILabel()
        label.text = "원산지"
        label.textColor = .black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let originLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(itemInfoTextLabel)
        itemInfoTextLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 16)
        
        let unitStack = UIStackView(arrangedSubviews: [unitTextLabel, unitLabel])
        unitStack.spacing = 30
        
        let volumeStack = UIStackView(arrangedSubviews: [volumeTextLabel, volumeLabel])
        volumeStack.spacing = 30
        
        let shiptypeStack = UIStackView(arrangedSubviews: [shiptypeTextLabel, shiptypeLabel])
        shiptypeStack.spacing = 30
        
        let originStack = UIStackView(arrangedSubviews: [originTextLabel, originLabel])
        originStack.spacing = 30
        
        addSubview(unitStack)
        unitStack.anchor(top: itemInfoTextLabel.bottomAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        addSubview(volumeStack)
        volumeStack.anchor(top: unitStack.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(shiptypeStack)
        shiptypeStack.anchor(top: volumeStack.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(originStack)
        originStack.anchor(top: shiptypeStack.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureText() {
        unitLabel.text = "100개씩 판매합니다."
        volumeLabel.text = "200kg입니다."
        shiptypeLabel.text = "우주선으로 배달됩니다."
        originLabel.text = "서울"
    }
    
}
