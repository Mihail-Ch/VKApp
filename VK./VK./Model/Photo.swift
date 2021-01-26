//
//  Photo.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import Foundation


class PhotoItems: Decodable {
    
    var id: Int = 0
    var ownerId: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case ownerId = "owner_id"
    }
}
