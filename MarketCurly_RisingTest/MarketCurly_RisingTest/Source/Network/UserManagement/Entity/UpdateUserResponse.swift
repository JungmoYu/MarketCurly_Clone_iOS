//
//  UpdateUserResponse.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/26.
//

struct UpdateUserResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: UpdateResultCode?
}

struct UpdateResultCode: Codable {
    var userIdx: Int
}
