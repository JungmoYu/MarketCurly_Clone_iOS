//
//  UserResponse.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/25.
//

struct UserResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [UserResponseResult]?
}

struct UserResponseResult: Codable {
    var user_id: String
    var name: String
    var email: String
    var phone: String
    var address: String
    var birthday: String
    var gender: String
    var mileage: String
    var status: String
}
