//
// Created by Alex Morkovkin on 01.12.2020.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        viewControllers = [createUsers(), createLeftUsers(), createStatistics(), createSettings()]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if selectedIndex == 0 {
            guard let nav = viewControllers?[0] as? UINavigationController,
                  let vc = nav.viewControllers[0] as? UsersViewController else { return }
            
            if vc.tableView.numberOfRows(inSection: 0) > 0 {
                vc.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
}

