//
//  VKResponse.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import Foundation


class VKResponse<T: Decodable>: Decodable {
     var count: Int
     var items: [T]
    
    enum CodingKeys: String, CodingKey {
        case response
        case count
        case items
    }

    required init(from decoder: Decoder) throws {
        let conteiner = try decoder.container(keyedBy: CodingKeys.self)
        let responseConteiner = try conteiner.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        self.count = try responseConteiner.decode(Int.self, forKey: .count)
        self.items = try responseConteiner.decode([T].self, forKey: .items)
    }
}
