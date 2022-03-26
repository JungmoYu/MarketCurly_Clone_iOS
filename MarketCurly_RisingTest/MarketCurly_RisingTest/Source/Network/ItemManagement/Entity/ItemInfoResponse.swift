//
//  ItemInfoResponse.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/26.
//

struct ItemInfoResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [ItemInfoResult]?
}

struct ItemInfoResult: Codable {
    var post_id: Int
    var image: String
    var vendor: String
    var title: String
    var intro: String
    var off: Int
}
