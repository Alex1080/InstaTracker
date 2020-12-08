//
//  UsersViewController.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 20.11.2020.
//

import UIKit
import SwiftyInsta

class UsersViewController: UIViewController {
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
        return tableView
    }()

    var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.hidesWhenStopped = true
        return loading
    }()
    
    var onlyI = [User]()
    var onlyThey = [User]()
    var common = [User]()

    let instagram = Instagram()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupViews()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        instagram.auth(view: self)
        self.prepareTable()
    }
    
    func prepareTable() {
        let following = Storage.shared.loadFollowing()
        let followed = Storage.shared.loadFollowed()
        
        let calculator = DiffCalculator()
        
        onlyI = calculator.diffState(newState: following, oldState: followed)
        onlyThey = calculator.diffState(newState: followed, oldState: following)
        common = calculator.common(newState: followed, oldState: following)
        
        tableView.reloadData()
    }
    
    @objc func updateTapped(_ sender: Any) {
        tableView.isHidden = true
        loading.startAnimating()

        let updater = UsersUpdater(instagram: instagram)

        updater.errorCompletion = { error in
            self.showAlert(title: "Error", msg: error.localizedDescription)
        }
        
        updater.updateFollowersAndFollowing {
            self.tableView.isHidden = false
            self.loading.stopAnimating()
            self.prepareTable()
        }
    }
}
