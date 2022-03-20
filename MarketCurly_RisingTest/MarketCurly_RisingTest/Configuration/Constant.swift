//
//  Constant.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import Foundation
import UIKit

struct Constant {
    
    // MARK: - URL
    
    static var LOGIN_REQUEST_URL = ""
    
    
    
    // MARK: - Constant
    
    static let PROFILE_HEADER_LOGGED_IN = CGFloat(200) // 160
    static let PROFILE_HEADER_LOGGED_OUT = CGFloat(220)
    
    static let CELL_DATA_LOGGED_IN = [CellData(opend: false, title: "1", sectionData: ["적립금",
                                                                                          "쿠폰",
                                                                                          "친구초대"]),
                                     CellData(opend: false, title: "2", sectionData: ["주문 내역",
                                                                                           "선물 내역",
                                                                                           "찜한 상품",
                                                                                           "상품 후기"]),
                                     CellData(opend: false, title: "3", sectionData: ["배송지 관리",
                                                                                         "컬리 퍼플 박스",
                                                                                         "개인정보 수정",
                                                                                         "알림 설정"]),
                                     CellData(opend: false, title: "4", sectionData: ["상품 문의",
                                                                                          "1:1 문의",
                                                                                          "대량주문 문의"]),
                                     CellData(opend: false, title: "5", sectionData: ["컬리소개",
                                                                                         "컬리패스",
                                                                                         "배송 안내",
                                                                                         "공지사항",
                                                                                         "자주하는 질문",
                                                                                         "고객센터",
                                                                                         "이용안내"]),
                                     CellData(opend: false, title: "6", sectionData: ["로그아웃"])]
    
    static let CELL_DATA_LOGGED_OUT = [CellData(opend: false, title: "1", sectionData: ["비회원 주문 조회",
                                                                                        "알림 설정"]),
                                     CellData(opend: false, title: "2", sectionData: ["컬리소개",
                                                                                        "배송 안내",
                                                                                        "공지사항",
                                                                                        "자주하는 질문",
                                                                                        "고객센터",
                                                                                        "이용안내"])]
    
}

