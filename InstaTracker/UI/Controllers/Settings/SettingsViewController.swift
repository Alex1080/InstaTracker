//
//  SettingsViewController.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 20.11.2020.
//

import UIKit
import Foundation
import SwiftyInsta

class SettingsViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SettingsViewController.cellIdentifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupHeaderView()
    }

    func setupHeaderView() {
        guard let key = UserDefaults.standard.string(forKey: "current.account") else {
            tableView.tableHeaderView = UIView()
            return print("`key` not found.")
        }

        guard let cache = Authentication.Response.persisted(with: key) else { return print("`Authentication.Response` not found.") }

        if let user = cache.user {
            tableView.tableHeaderView = HeaderView(
                    name: user.name,
                    username: user.username,
                    email: user.email,
                    phone: user.phoneNumber,
                    imageUrl: user.thumbnail
            )
        } else {
            tableView.tableHeaderView = UIView()
        }

        tableView.tableHeaderView?.layoutIfNeeded()
    }
}
