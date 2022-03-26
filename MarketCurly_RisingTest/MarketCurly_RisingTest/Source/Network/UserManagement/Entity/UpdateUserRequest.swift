//
//  UpdateUserRequest.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/26.
//

struct UpdateUserRequest: Codable {    
    var password: String?
    var email: String?
    var phone: String?
    var address: String?
    var birthday: String?
    var gender: String?
}
