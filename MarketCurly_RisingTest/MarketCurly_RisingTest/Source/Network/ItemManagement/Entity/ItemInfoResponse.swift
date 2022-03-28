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
    var title_price: Int
    var intro: String
    var off: Int
    var item_list: [ItemList]
}

struct ItemList: Codable {
    var item_id: Int
    var item_name: String
    var item_image: String
    var item_price: Int
    var gift_enable: Int
}

struct ItemInfoDetailResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [ItemInfoDetailResult]?
}

struct ItemInfoDetailResult: Codable {
    var name: String
    var price: Int
    var gift_enable: Int
    var data: String
}
