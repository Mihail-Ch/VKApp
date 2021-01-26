//
//  Session.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    private init() { }
    
    var token: String = ""
    var userId: Int = 0

}
