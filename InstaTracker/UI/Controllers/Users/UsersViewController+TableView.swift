//
//  UsersViewController+TableView.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 30.11.2020.
//

import UIKit

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: Section.init(rawValue: section)!)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.titleForHeaderInSection(section: Section.init(rawValue: section)!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as! UserTableViewCell

        cell.viewModel = viewModel.getUserForSection(indexPath: indexPath)
        cell.layoutIfNeeded()

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == Section.OnlyI.rawValue && editingStyle == .delete{
            viewModel.onlyI.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        indexPath.section == Section.OnlyI.rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.getUserForSection(indexPath: indexPath)
        InstagramOpener().open(username: user.username)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
