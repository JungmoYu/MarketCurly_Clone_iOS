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
    var basketId: Int
    var vendor: String
    var itemName: String
    var title: String
    var data: String
    var price: Int
    var off: Int
    var quantity: Int
}

struct AddToCartResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [BasketID]?
}

struct BasketID: Codable {
    var basketID: Int
}
