//
//  JoinUserResponse.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/25.
//

struct JoinUserResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ResultCode?
}

struct ResultCode: Codable {
    var userIdx: Int
}
