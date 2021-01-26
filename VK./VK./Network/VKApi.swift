//
//  VKApi.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import Foundation


final class VKApi {
    
    let session = Session.shared
    
    enum ApiMethod {
        case friends
        case groups
        case searchGroups(searchText: String)
        case photos(id: String)
        
        var path: String {
            switch self {
            case .friends:
                return "/method/friends.get"
            case .groups:
                return  "/method/groups.get"
            case .photos:
                return "photos.getAll"
            case .searchGroups:
                return  "groups.search"
            }
        }
        
        var parameters: [String: String] {
            switch self {
            case .friends:
                return ["fields": "photo_50",
                        "count": "15"]
            case .groups:
                return ["count": "10",
                        "extended": "1"]
            case .photos(let id):
                return ["owner_id": id]
            case .searchGroups(let searchText):
                return ["q": searchText]
            }
        }
    }
    
    private func request(_ method: ApiMethod, complition: @escaping (Data?) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = method.path
        let defaultQueryItems = [
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.126")
        ]
        let methodQueryItems = method.parameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        components.queryItems = defaultQueryItems + methodQueryItems
        
        guard let url = components.url else {
            complition(nil)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                complition(data)
            }
        }
        task.resume()
    }
    
    func getFriends(completion: @escaping ([User]) -> Void) {
        request(.friends) { (data) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(VKResponse<User>.self, from: data)
                completion(response.items)
            } catch {
                print(error)
            }
        }
    }
    
    func getGroups(completion: @escaping ([GroupItems]) -> Void) {
        request(.groups) { (data) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(VKResponse<GroupItems>.self, from: data)
                completion(response.items)
            } catch {
                print(error)
            }
        }
    }
    
    func searchGetGroups(searchText: String ,complition: @escaping ([GroupItems]) -> Void) {
        request(.searchGroups(searchText: searchText)) { (data) in
            guard let data = data else {return}
            do {
                let response = try JSONDecoder().decode(VKResponse<GroupItems>.self, from: data)
                complition(response.items)
            } catch {
                print(error)
            }
        }
    }
    
    func getFriendsPhoto(complition: @escaping([User]) -> Void) {
        request(.photos(id: session.token)) { (data) in
            guard let data = data else {return}
            do {
                let response = try JSONDecoder().decode(VKResponse<User>.self, from: data)
                complition(response.items)
            } catch {
                print(error)
            }
        }
    }
}
    
    
    

