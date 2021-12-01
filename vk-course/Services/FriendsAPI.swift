//
//  FriendsAPI.swift
//  vk-course
//
//  Created by Artur Igberdin on 01.12.2021.
//

import Foundation
import Alamofire

final class FriendsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = ""
    let userId = "223761261"
    let version = "5.131"
    
    //TODO: - расшири токеном и возврат значения через кложур
    
    func getFriends() {
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order":"name",
            "count":100,
            "fields": "city, photo_100",
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            //Оператор распаковки в значение и раннего выхода
            guard let data = response.data else { return }
            
            debugPrint(response.result)
            debugPrint(data.prettyJSON ?? "")
            
        }
        
//        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//
//        }
    }
    
}
