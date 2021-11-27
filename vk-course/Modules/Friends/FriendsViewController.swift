//
//  FriendsViewController.swift
//  vk-course
//
//  Created by Artur Igberdin on 27.11.2021.
//

import UIKit

class FriendsViewController: UITableViewController {

    let friends = ["Jack", "Nick", "Lucky"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //indexPath.row
        //indexPath.section
        
        cell.textLabel?.text = friends[indexPath.row]
        
        return cell
    }


}
