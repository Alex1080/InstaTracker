//
//  LeftUserViewController+SetupViews.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 30.11.2020.
//

import Foundation
import UIKit

extension LeftUsersViewController {
    func setupViews() {
        addViews()
        constraintSubviews()
    }

    fileprivate func addViews() {
        view.addSubview(tableView)
    }

    fileprivate func constraintSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
