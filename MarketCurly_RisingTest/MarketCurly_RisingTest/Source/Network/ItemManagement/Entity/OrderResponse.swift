//
//  OrderResponse.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/04/01.
//

struct OrderRequest: Codable {
    var orderList: [Int]
    var pay: String
}

struct Order: Codable {
    var basket_id: Int
}

struct OrderResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
//    var result: OrderResult?
}

struct OrderResult: Codable {
//    var basket_id1: Int
    var pay: String
}


struct OrderListResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [OrderListResult]?
}

struct OrderListResult: Codable {
    var vendor: String
    var image: String
    var item_name: String
    var title: String
    var item_price: Int
    var quantity: Int
    var group: Int
    var pay: String
    var order_date: String
    var address: String
    var status: String
}
