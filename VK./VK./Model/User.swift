//
//  User.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import Foundation

class User:  Decodable {
    
    var id: Int
    var firstName: String
    var lastName: String
    var avatar: String
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
    }
}
