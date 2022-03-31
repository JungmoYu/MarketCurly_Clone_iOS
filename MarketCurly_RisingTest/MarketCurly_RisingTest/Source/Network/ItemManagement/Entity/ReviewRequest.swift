//
//  ReviewRequest.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/29.
//

struct ReviewRequest {
    var item_id: Int
    var title: String
    var content: String
}

struct ReviewRequestResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ReviewRequestResult
}

struct ReviewRequestResult: Codable {
    var review_id: Int
}
