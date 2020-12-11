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
}
