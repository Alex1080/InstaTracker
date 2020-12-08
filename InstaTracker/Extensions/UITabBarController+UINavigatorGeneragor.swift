//
// Created by Alex Morkovkin on 01.12.2020.
//

import UIKit

extension UITabBarController {
    public func createNavigationController(rootViewController: UIViewController, title: String, prefersLargeTitle: Bool, image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)

        navigationController.navigationBar.prefersLargeTitles = prefersLargeTitle
        navigationController.topViewController?.title = title
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image

        return navigationController
    }
}