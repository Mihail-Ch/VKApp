//
//  Repository.swift
//  VK.
//
//  Created by Михаил Чертов on 15.02.2021.
//

import Foundation
import RealmSwift

class Repository {
    private let realm = try! Realm()
    
    func fetchFriends() -> [User] {
        return  Array(realm.objects(User.self))
    }
    
    func fetchPhotos(ownerId: Int) -> [Photo] {
        return  Array(realm.objects(Photo.self).filter("ownerId == %@", ownerId))
    }
}

