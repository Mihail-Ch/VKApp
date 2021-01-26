//
//  Group.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import Foundation

class GroupItems:  Decodable {
    
    var id: Int = 0
    var name: String = ""
    var avatar: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case avatar = "photo_50"
    }
}
