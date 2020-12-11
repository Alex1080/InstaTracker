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
    
    var viewModel: LeftUserViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
