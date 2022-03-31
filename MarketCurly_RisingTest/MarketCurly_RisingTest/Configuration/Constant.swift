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
    
    static var JWT = ""
    static var USER_INDEX = -1
    static var BASE_URL = "https://dev.sosocamp.shop/"
    static var JOIN_QUERY = "users"
    static var LOGIN_QUERY = "users/login"
    static var SEARCH_USERINDEX = "users/"
    static var DEAL_ITEM_QUERY = "deal-items?createDate="
    static var RANDOM_ITEM_QUERY = "random-items?createDate="
    static var RECOMMEND_ITEM_QUERY = "recommend-items?createDate="
    static var ITEM_DETAIL_QUERY = "items?postId="
    
    static var CART = "baskets"
    static var REVIEW = "reviews"
    static var GETREVIEWS = "?postId="
    
    static var ORDER_LIST = "order-lists"
    
    // MARK: - User
    static var User: UserResponseResult?

    
    // MARK: - Constant
    
    
    static let TOTAL_AGREE_BTN_TAG = 99999
    
    static let PROFILE_HEADER_LOGGED_IN = CGFloat(200) // 160
    static let PROFILE_HEADER_LOGGED_OUT = CGFloat(220)
    
    static let RECOMMENDED_ITEM = ["불고기", "갈비탕", "돈까스", "밀키트", "마스크", "닭갈비", "떡", "갤럭시 사전예약"]
    
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
                                     CellData(opend: false, title: "6", sectionData: ["로그아웃", "회원탈퇴"])]
    
    static let CELL_DATA_LOGGED_OUT = [CellData(opend: false, title: "1", sectionData: ["비회원 주문 조회",
                                                                                        "알림 설정"]),
                                     CellData(opend: false, title: "2", sectionData: ["컬리소개",
                                                                                        "배송 안내",
                                                                                        "공지사항",
                                                                                        "자주하는 질문",
                                                                                        "고객센터",
                                                                                        "이용안내"])]
    
    static var CATEGORY_DATA = [ CellData(opend: false, title: "🥬 채소", sectionData: ["        친환경",
                                                                                      "        고구마﹒감자﹒당근",
                                                                                      "        시금치﹒쌈채소﹒나물",
                                                                                      "        브로콜리﹒파프리카﹒양배추"]),
                                    CellData(opend: false, title: "🍎 과일﹒견과﹒쌀", sectionData: ["        친환경",
                                                                                    "        제철과일",
                                                                                    "        국산과일",
                                                                                    "        수입과일"]),
                                    CellData(opend: false, title: "🐟 수산﹒해산﹒건어물", sectionData: ["        제철수산",
                                                                                    "        생선류",
                                                                                    "        굴비류﹒반건류",
                                                                                    "        오징어﹒낙지﹒문어"]),
                                    CellData(opend: false, title: "🍖 정육﹒계란", sectionData: ["        국내산 소고기",
                                                                                    "        수입산 소고기",
                                                                                    "        돼지고기",
                                                                                    "        계란류"]),
                                    CellData(opend: false, title: "🍚 국﹒반찬﹒메인요리", sectionData: ["        국﹒탕﹒찌개",
                                                                                    "        밀키트﹒메인요리",
                                                                                    "        밑반찬",
                                                                                    "        김치﹒젓갈﹒장류"]),
                                     CellData(opend: false, title: "🥬 채소", sectionData: ["        친환경",
                                                                                       "        고구마﹒감자﹒당근",
                                                                                       "        시금치﹒쌈채소﹒나물",
                                                                                       "        브로콜리﹒파프리카﹒양배추"]),
                                     CellData(opend: false, title: "🍎 과일﹒견과﹒쌀", sectionData: ["        친환경",
                                                                                     "        제철과일",
                                                                                     "        국산과일",
                                                                                     "        수입과일"]),
                                     CellData(opend: false, title: "🐟 수산﹒해산﹒건어물", sectionData: ["        제철수산",
                                                                                     "        생선류",
                                                                                     "        굴비류﹒반건류",
                                                                                     "        오징어﹒낙지﹒문어"]),
                                     CellData(opend: false, title: "🍖 정육﹒계란", sectionData: ["        국내산 소고기",
                                                                                     "        수입산 소고기",
                                                                                     "        돼지고기",
                                                                                     "        계란류"]),
                                     CellData(opend: false, title: "🍚 국﹒반찬﹒메인요리", sectionData: ["        국﹒탕﹒찌개",
                                                                                     "        밀키트﹒메인요리",
                                                                                     "        밑반찬",
                                                                                     "        김치﹒젓갈﹒장류"]),
                                     CellData(opend: false, title: "🥬 채소", sectionData: ["        친환경",
                                                                                       "        고구마﹒감자﹒당근",
                                                                                       "        시금치﹒쌈채소﹒나물",
                                                                                       "        브로콜리﹒파프리카﹒양배추"]),
                                     CellData(opend: false, title: "🍎 과일﹒견과﹒쌀", sectionData: ["        친환경",
                                                                                     "        제철과일",
                                                                                     "        국산과일",
                                                                                     "        수입과일"]),
                                     CellData(opend: false, title: "🐟 수산﹒해산﹒건어물", sectionData: ["        제철수산",
                                                                                     "        생선류",
                                                                                     "        굴비류﹒반건류",
                                                                                     "        오징어﹒낙지﹒문어"]),
                                     CellData(opend: false, title: "🍖 정육﹒계란", sectionData: ["        국내산 소고기",
                                                                                     "        수입산 소고기",
                                                                                     "        돼지고기",
                                                                                     "        계란류"]),
                                     CellData(opend: false, title: "🍚 국﹒반찬﹒메인요리", sectionData: ["        국﹒탕﹒찌개",
                                                                                     "        밀키트﹒메인요리",
                                                                                     "        밑반찬",
                                                                                     "        김치﹒젓갈﹒장류"]),
                                     CellData(opend: false, title: "🥬 채소", sectionData: ["        친환경",
                                                                                       "        고구마﹒감자﹒당근",
                                                                                       "        시금치﹒쌈채소﹒나물",
                                                                                       "        브로콜리﹒파프리카﹒양배추"]),
                                     CellData(opend: false, title: "🍎 과일﹒견과﹒쌀", sectionData: ["        친환경",
                                                                                     "        제철과일",
                                                                                     "        국산과일",
                                                                                     "        수입과일"]),
                                     CellData(opend: false, title: "🐟 수산﹒해산﹒건어물", sectionData: ["        제철수산",
                                                                                     "        생선류",
                                                                                     "        굴비류﹒반건류",
                                                                                     "        오징어﹒낙지﹒문어"]),
                                     CellData(opend: false, title: "🍖 정육﹒계란", sectionData: ["        국내산 소고기",
                                                                                     "        수입산 소고기",
                                                                                     "        돼지고기",
                                                                                     "        계란류"]),
                                     CellData(opend: false, title: "🍚 국﹒반찬﹒메인요리", sectionData: ["        국﹒탕﹒찌개",
                                                                                     "        밀키트﹒메인요리",
                                                                                     "        밑반찬",
                                                                                     "        김치﹒젓갈﹒장류"]),
                                     CellData(opend: false, title: "🥬 채소", sectionData: ["        친환경",
                                                                                       "        고구마﹒감자﹒당근",
                                                                                       "        시금치﹒쌈채소﹒나물",
                                                                                       "        브로콜리﹒파프리카﹒양배추"]),
                                     CellData(opend: false, title: "🍎 과일﹒견과﹒쌀", sectionData: ["        친환경",
                                                                                     "        제철과일",
                                                                                     "        국산과일",
                                                                                     "        수입과일"]),
                                     CellData(opend: false, title: "🐟 수산﹒해산﹒건어물", sectionData: ["        제철수산",
                                                                                     "        생선류",
                                                                                     "        굴비류﹒반건류",
                                                                                     "        오징어﹒낙지﹒문어"]),
                                     CellData(opend: false, title: "🍖 정육﹒계란", sectionData: ["        국내산 소고기",
                                                                                     "        수입산 소고기",
                                                                                     "        돼지고기",
                                                                                     "        계란류"]),
                                     CellData(opend: false, title: "🍚 국﹒반찬﹒메인요리", sectionData: ["        국﹒탕﹒찌개",
                                                                                     "        밀키트﹒메인요리",
                                                                                     "        밑반찬",
                                                                                     "        김치﹒젓갈﹒장류"])]
    
    
}

