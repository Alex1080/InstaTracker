//
//  LeftUserViewController+TableView.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 30.11.2020.
//

import UIKit

extension LeftUsersViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as! UserTableViewCell
        
        let user = users[indexPath.row]
        
        if user.name.isEmpty {
            cell.name!.isHidden = true
        } else {
            cell.name!.text = user.name
        }
        
        cell.username.text = user.username
        cell.whenLeft.text = L10n.Navigation.Tab.LeftUsers.whenLeft + " \(dates[user.username]!)"
        cell.profilePicture.image = UIImage(named: "Image")
        cell.lockIcon.isHidden = !user.isPrivate

        if let url = user.picture {
            cell.profilePicture.loadImage(at: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        InstagramOpener().open(username: user.username)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
