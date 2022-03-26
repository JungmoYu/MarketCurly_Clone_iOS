//
//  LoginUserResponse.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/25.
//

struct LoginUserResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: LoginResultCode?
}

struct LoginResultCode: Codable {
    var userIdx: Int
    var jwt: String
}
