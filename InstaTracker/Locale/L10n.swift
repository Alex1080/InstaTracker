//
// Created by Alex Morkovkin on 02.12.2020.
//

import Foundation

class L10n {
    class Navigation {
        class Tab {
            static let users = NSLocalizedString("navigation.tab.users", comment: "")
            static let leftUsers = NSLocalizedString("navigation.tab.leftUsers", comment: "")
            static let statistics = NSLocalizedString("navigation.tab.statistics", comment: "")
            static let settings = NSLocalizedString("navigation.tab.settings", comment: "")

            class Users {
                static let update = NSLocalizedString("navigation.tab.users.update", comment: "")

                static let onlyI = NSLocalizedString("navigation.tab.users.table.onlyI", comment: "")
                static let onlyThey = NSLocalizedString("navigation.tab.users.table.onlyThey", comment: "")
                static let both = NSLocalizedString("navigation.tab.users.table.both", comment: "")
            }

            class LeftUsers {
                static let whenLeft = NSLocalizedString("navigation.tab.leftUsers.whenLeft", comment: "")
            }

            class Settings {
                static let clear = NSLocalizedString("navigation.tab.settings.button.clear", comment: "")
                static let logOut = NSLocalizedString("navigation.tab.settings.button.logOut", comment: "")
            }
        }
    }

    class Alert {
        static let notification = NSLocalizedString("alert.notification", comment: "")
        static let cleared = NSLocalizedString("alert.cleared", comment: "")
        static let logOut = NSLocalizedString("alert.logOut", comment: "")
    }
    
    class Notifications {
        static let title = NSLocalizedString("notification.title", comment: "")
        static let body = NSLocalizedString("notification.body", comment: "")
    }
}
