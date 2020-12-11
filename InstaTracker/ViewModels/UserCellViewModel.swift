//
//  UserCellViewModel.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 11.12.2020.
//

import Foundation

class UserCellViewModel {
    var username: String
    var name: String
    var profilePicture: URL?

    var nameHidden: Bool
    var whenLeftHidden: Bool
    let lockIconHidden: Bool

    var whenLeft: String?

    init(user: User) {
        self.username = user.username
        self.name = user.name
        self.profilePicture = user.picture
        self.nameHidden = name.isEmpty
        self.whenLeftHidden = whenLeft == nil
        self.lockIconHidden = !user.isPrivate
    }

    convenience init(user: User, date: String) {
        self.init(user: user)
        self.whenLeft = L10n.Navigation.Tab.LeftUsers.whenLeft + " \(date)"
    }
}
