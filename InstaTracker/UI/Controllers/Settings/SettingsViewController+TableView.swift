//
//  SettingsViewController+TableView.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 30.11.2020.
//

import Foundation
import UIKit

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ButtonAction.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewController.cellIdentifier, for: indexPath)

        let menuItem = ButtonAction.init(rawValue: indexPath.row)!
        cell.textLabel?.text = menuItem.getTitle()
        cell.imageView?.image = menuItem.getImage()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let button = ButtonAction.init(rawValue: indexPath.row)!
        button.action(vc: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
