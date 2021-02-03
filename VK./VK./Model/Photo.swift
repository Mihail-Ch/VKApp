//
//  Photo.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import Foundation

class Photo: Decodable {
    
    var id: Int = 0
    var ownerId: Int = 0
    var sizes: [PhotoSize]
    
    var imageUrl: String {
        return sizes.first?.url ?? "" 
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
    }
}

class PhotoSize: Decodable {
    var url: String
    
}
