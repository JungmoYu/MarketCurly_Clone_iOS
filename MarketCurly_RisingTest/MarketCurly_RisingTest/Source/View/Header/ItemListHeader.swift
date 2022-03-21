//
//  ItemListHeader.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit
import Lottie

class ItemListHeader: UICollectionReusableView {
    // MARK: - Properties
    
    static let identifier: String = String(describing: ItemListHeader.self)
    var clockTimer: Timer?
    var clockAnimated: Bool = false
    var isClockTimerRunning: Bool = false
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "이 상품 어때요?"
        label.textColor = .darkGray
        return label
    }()
    
    private let dailyPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "24시간 한정 특가"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let animationClock: AnimationView = {
        let av = AnimationView(name: "clock_1s")
        av.contentMode = .scaleToFill
        return av
    }()
    
    private let restTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var viewAllBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("전체보기 ›", for: .normal)
        btn.setTitleColor(.mainPurple, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(viewAllBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Actions
    
    @objc func viewAllBtnDidTap() {
        print("ItemListHeader - viewAllBtnDidTap() called")
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(viewAllBtn)
        viewAllBtn.centerY(inView: self)
        viewAllBtn.anchor(right: rightAnchor, paddingRight: 16)
        
        addSubview(headerTitleLabel)
        headerTitleLabel.centerY(inView: self)
        headerTitleLabel.anchor(left: leftAnchor, paddingLeft: 16)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureCell(isDailyPrice: Bool) {
        if isDailyPrice {
            viewAllBtn.setTitle("", for: .normal)
            headerTitleLabel.text = "일일특가"
            
            addSubview(dailyPriceLabel)
            dailyPriceLabel.anchor(top: headerTitleLabel.bottomAnchor, left: leftAnchor,
                                   paddingTop: 5 , paddingLeft: 16)
            
            addSubview(animationClock)
            animationClock.setDimensions(height: 30, width: 30)
            animationClock.anchor(top: dailyPriceLabel.bottomAnchor, left: leftAnchor, paddingLeft: 16)
            
            addSubview(restTimeLabel)
            restTimeLabel.centerY(inView: animationClock)
            restTimeLabel.anchor(left: animationClock.rightAnchor, paddingLeft: 5)
            
            makeAndFireTimer()
        }
    }
    
    func makeAndFireTimer() {
        isClockTimerRunning = true
        DispatchQueue.global().async {
            let runLoop = RunLoop.current
            self.clockTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { Timer in
                let formatter = DateFormatter()
                let date = Date()
                formatter.dateFormat = "H:mm:ss"
                DispatchQueue.main.async {
                    self.clockAnimated = true
                    if self.clockAnimated {
                        self.animationClock.play(completion: nil)
                        self.restTimeLabel.text = formatter.string(from: date)
                    }
                    self.clockAnimated = false
                }
            }
            while self.isClockTimerRunning {
                    runLoop.run(until: Date().addingTimeInterval(0.1))
                }
        }
    }

}

