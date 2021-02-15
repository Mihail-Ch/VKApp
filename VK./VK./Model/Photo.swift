//
//  Photo.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import Foundation
import RealmSwift

final class Photo:Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var imageUrl: String = ""
    
    static override func primaryKey() -> String? {
        return "id"
    }
       
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case url
        case sizes
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.ownerId = try container.decode(Int.self, forKey: .ownerId)
        
        var sizesArrayContainer = try container.nestedUnkeyedContainer(forKey: .sizes)
        let firstContainer = try sizesArrayContainer.nestedContainer(keyedBy: CodingKeys.self)
        self.imageUrl = try firstContainer.decode(String.self, forKey: .url)
    }
}

class PhotoSize: Decodable {
    var url: String
}
