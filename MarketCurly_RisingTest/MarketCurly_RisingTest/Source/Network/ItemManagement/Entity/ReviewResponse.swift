//
//  ReviewResponse.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/29.
//




struct ReviewResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [ReviewResponseResult]?
}

struct ReviewResponseResult: Codable {
    var review_id: Int
    var title: String
    var name: String
    var content: String
    var createDate: String
}
