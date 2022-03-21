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
    
//    static let JOIN_FORM_DATA_LIST = ["아이디", "비밀번호", "비밀번호 확인", "이름", "이메일", "휴대폰", "주소"]
//    static let JOIN_FORM_PLACEHOLDER_LIST = ["예: marketKurly12", "비밀번호를 입력해주세요", ""]
    
    static let TOTAL_AGREE_BTN_TAG = 99999
    
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

