//
//  ButtonAction.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 30.11.2020.
//

import Foundation
import UIKit

enum ButtonAction: Int, CaseIterable {
    case clear = 0
    case logOut = 1

    private static let menuItems = [
        L10n.Navigation.Tab.Settings.clear,
        L10n.Navigation.Tab.Settings.logOut
    ]

    private static let menuIcons = [
        UIImage(systemName: "arrow.rectanglepath"),
        UIImage(systemName: "xmark.circle")
    ]
    
    func getTitle() -> String {
        ButtonAction.menuItems[self.rawValue]
    }
    
    func getImage() -> UIImage {
        ButtonAction.menuIcons[self.rawValue]!
    }
    
    func action(vc: UIViewController) {
        switch self {
        case .clear:
            Storage.shared.clearShapshots()
            vc.showAlert(title: L10n.Alert.notification, msg: L10n.Alert.cleared)
        case .logOut:
            Storage.shared.clearEverything()
            UserDefaults.standard.removeObject(forKey: "current.account")
            vc.showAlert(title: L10n.Alert.notification, msg: L10n.Alert.logOut) { _ in
                vc.tabBarController?.selectedIndex = 0
            }
        }
    }
}
