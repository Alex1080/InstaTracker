//
//  DiffCalculator.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 25.11.2020.
//

import Foundation

class DiffCalculator {
    
    func diffState(newState: [User], oldState: [User]) -> [User] {
        var result = [User]()
        let newStateSet = Set(newState)

        for user in oldState {
            if !newStateSet.contains(user) {
                result.append(user)
            }
        }

        return result
    }
    
    func common(newState: [User], oldState: [User]) -> [User] {
        var result = [User]()
        
        let leftSet = Set(newState)
        let rightSet = Set(oldState)

        let both = leftSet.intersection(rightSet)
        
        for user in newState {
            if both.contains(user) {
                result.append(user)
            }
        }
        
        return result
    }
}
