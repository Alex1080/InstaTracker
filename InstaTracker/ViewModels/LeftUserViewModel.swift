//
//  LeftUserViewModel.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 11.12.2020.
//

import Foundation

class LeftUserViewModel {
    var users = [UserCellViewModel]()
    
    init() {
        prepareViewModels()
    }
    
    fileprivate func prepareViewModels() {
        var dates = [String:String]()

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"

        users = Storage.shared.loadShapshots().flatMap { (snapshot) -> [User] in
            for follower in snapshot.followers! {
                dates[follower.username] = formatter.string(from: snapshot.date!)
            }
            
            return snapshot.followers!
        }.map {UserCellViewModel(user: $0, date: dates[$0.username]!)}
    }

}
