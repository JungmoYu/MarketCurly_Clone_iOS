//
//  CartListResponse.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/27.
//

struct CartListResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [CartListResult]?
}

struct CartListResult: Codable {
    var basket_id: Int
    var image: String
    var vendor: String
    var title: String
    var off: Int
    var item_id: Int
    var item_name: String
    var item_price: Int
    var quantity: Int
}

struct AddToCartRequest: Codable {
    var item_list: [AddToCartItem]
}

struct AddToCartItem: Codable {
    var id: Int
    var quantity: Int
}

struct AddToCartResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
//    var result: BasketID
}

struct BasketID: Codable {
    var basket_id: [Int]
}
