//
//  Group.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import Foundation
import RealmSwift

class GroupItems: Object,  Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case avatar = "photo_50"
    }
}
