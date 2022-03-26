//
//  JoinUserRequest.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/25.
//

struct JoinUserRequest: Codable {
    var id: String
    var password: String
    var name: String
    var email: String
    var phone: String
    var address: String?
    var birthday: String?
    var gender: String?
}
