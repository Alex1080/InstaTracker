//
//  LeftUsersViewController.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 25.11.2020.
//

import Foundation
import UIKit

class LeftUsersViewController: UIViewController {
    var tableView:UITableView = {
        let tableView = UITableView()

        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()

        return tableView
    }()
    
    var users = [User]()
    var dates: [String:String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareUsers()
        tableView.reloadData()
    }
    
    fileprivate func prepareUsers() {
        dates = [String:String]()

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"

        users = Storage.shared.loadShapshots().flatMap { (snapshot) -> [User] in
            for follower in snapshot.followers! {
                dates[follower.username] = formatter.string(from: snapshot.date!)
            }
            
            return snapshot.followers!
        }
    }
}
