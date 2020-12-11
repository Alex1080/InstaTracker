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
        var count: Int

        switch section {
        case Section.OnlyI.rawValue:
            count = viewModel.onlyI.count
        case Section.OnlyThey.rawValue:
            count = viewModel.onlyThey.count
        case Section.Both.rawValue:
            count = viewModel.common.count
        default:
            fatalError("Not all cases were implemented")
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header: String

        switch section {
        case Section.OnlyI.rawValue:
            header = L10n.Navigation.Tab.Users.onlyI + " (\(viewModel.onlyI.count))";
        case Section.OnlyThey.rawValue:
            header = L10n.Navigation.Tab.Users.onlyThey + " (\(viewModel.onlyThey.count))"
        case Section.Both.rawValue:
            header = L10n.Navigation.Tab.Users.both + " (\(viewModel.common.count))"
        default:
            fatalError("Not all cases were implemented")
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as! UserTableViewCell

        cell.viewModel = getUserForSection(indexPath: indexPath)
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
        let user = getUserForSection(indexPath: indexPath)
        InstagramOpener().open(username: user.username)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getUserForSection(indexPath: IndexPath) -> UserCellViewModel {
        var user: UserCellViewModel

        switch indexPath.section {
        case Section.OnlyI.rawValue:
            user = viewModel.onlyI[indexPath.row]
        case Section.OnlyThey.rawValue:
            user = viewModel.onlyThey[indexPath.row]
        case Section.Both.rawValue:
            user = viewModel.common[indexPath.row]
        default:
            fatalError("Not all cases were implemented")
        }

        return user
    }
}
