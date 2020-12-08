//
// Created by Alex Morkovkin on 01.12.2020.
//

import UIKit

extension MainTabBarController {
    fileprivate static let boldConfig = UIImage.SymbolConfiguration(weight: .heavy)

    func createUsers() -> UIViewController {
        let users = UsersViewController()
        let usersImage = UIImage(systemName: "person.3.fill", withConfiguration: MainTabBarController.boldConfig)!

        let navigationController = createNavigationController(
                rootViewController: users,
                title: L10n.Navigation.Tab.users,
                prefersLargeTitle: true,
                image: usersImage
        )

        let button = UIBarButtonItem(
                title: L10n.Navigation.Tab.Users.update,
                style: .plain,
                target: users,
                action: #selector(users.updateTapped(_:))
        )

        navigationController.topViewController?.navigationItem.rightBarButtonItem = button

        return navigationController
    }

    func createLeftUsers() -> UIViewController {
        let leftUsers = LeftUsersViewController()
        let leftUsersImage = UIImage(systemName: "person.badge.minus", withConfiguration: MainTabBarController.boldConfig)!

        return createNavigationController(
                rootViewController: leftUsers,
                title: L10n.Navigation.Tab.leftUsers,
                prefersLargeTitle: true,
                image: leftUsersImage
        )
    }

    func createStatistics() -> UIViewController {
        let statistics = StatisticViewController()
        let statisticImage = UIImage(systemName: "chart.bar.xaxis", withConfiguration: MainTabBarController.boldConfig)!

        return createNavigationController(
                rootViewController: statistics,
                title: L10n.Navigation.Tab.statistics,
                prefersLargeTitle: false,
                image: statisticImage
        )
    }

    func createSettings() -> UIViewController {
        let settings = SettingsViewController()
        let settingsImage = UIImage(systemName: "list.dash", withConfiguration: MainTabBarController.boldConfig)!

        return createNavigationController(
                rootViewController: settings,
                title: L10n.Navigation.Tab.settings,
                prefersLargeTitle: false,
                image: settingsImage
        )
    }

}