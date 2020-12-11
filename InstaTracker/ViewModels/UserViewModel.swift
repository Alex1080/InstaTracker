//
//  UserViewModel.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 11.12.2020.
//

import Foundation

class UserViewModel {
    var onlyI = [UserCellViewModel]()
    var onlyThey = [UserCellViewModel]()
    var common = [UserCellViewModel]()
    
    init() {
        refresh()
    }
    
    func refresh() {
        let following = Storage.shared.loadFollowing()
        let followed = Storage.shared.loadFollowed()
        
        let calculator = DiffCalculator()
        
        onlyI = calculator.diffState(newState: following, oldState: followed).map {UserCellViewModel(user: $0)}
        onlyThey = calculator.diffState(newState: followed, oldState: following).map {UserCellViewModel(user: $0)}
        common = calculator.common(newState: followed, oldState: following).map {UserCellViewModel(user: $0)}
    }
    
    func numberOfRowsInSection(section: Section) -> Int {
        var count: Int

        switch section {
        case Section.OnlyI:
            count = onlyI.count
        case Section.OnlyThey:
            count = onlyThey.count
        case Section.Both:
            count = common.count
        }
        
        return count
    }
    
    func titleForHeaderInSection(section: Section) -> String? {
        var header: String

        switch section {
        case Section.OnlyI:
            header = L10n.Navigation.Tab.Users.onlyI + " (\(onlyI.count))";
        case Section.OnlyThey:
            header = L10n.Navigation.Tab.Users.onlyThey + " (\(onlyThey.count))"
        case Section.Both:
            header = L10n.Navigation.Tab.Users.both + " (\(common.count))"
        }
        
        return header
    }
    
    func getUserForSection(indexPath: IndexPath) -> UserCellViewModel {
        var user: UserCellViewModel

        let section = Section.init(rawValue: indexPath.section)!
        let index = indexPath.row
        
        switch section {
        case Section.OnlyI:
            user = onlyI[index]
        case Section.OnlyThey:
            user = onlyThey[index]
        case Section.Both:
            user = common[index]
        }

        return user
    }
}
