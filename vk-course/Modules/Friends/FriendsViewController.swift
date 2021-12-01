//
//  FriendsViewController.swift
//  vk-course
//
//  Created by Artur Igberdin on 27.11.2021.
//

import UIKit

final class FriendsViewController: UITableViewController {
    
    let friendsAPI = FriendsAPI()

    private let friends = ["Jack", "Nick", "Lucky"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        //TODO: - Сохранить в масси и отобразить
        friendsAPI.getFriends()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = friends[indexPath.row]
        
        return cell
    }


}
