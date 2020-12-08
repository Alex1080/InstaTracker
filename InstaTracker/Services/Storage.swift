//
//  Storage.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 02.10.2020.
//

import Foundation
import SwiftyInsta
import CoreData

class Storage {
    static let shared = Storage()

    private init() {}

    fileprivate let store = UserDefaults.standard

    fileprivate let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - Full reset
    
    fileprivate enum EntityName: String {
        case snapshot = "Snapshot"
        case userState = "UserState"
        case statistic = "Statistic"
    }
    
    fileprivate enum StatisticType: Int64 {
        case followed = 0
        case following = 1
    }
    
    func clearEverything() {
        clearShapshots()
        clearUsers()
        clearStatistic()
    }
    
    func clearShapshots() {
        clearEntity(entityName: EntityName.snapshot.rawValue)
    }
    
    func clearUsers() {
        clearEntity(entityName: EntityName.userState.rawValue)
    }
    
    func clearStatistic() {
        clearEntity(entityName: EntityName.statistic.rawValue)
    }
    
    func clearEntity(entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Snapshots
    
    func loadShapshots() -> [Snapshot] {
        var result = [Snapshot]()
        
        let request = Snapshot.fetchRequest() as NSFetchRequest<Snapshot>
        
        do {
            result = try context.fetch(request).reversed()
        } catch {
            print(error.localizedDescription)
        }
        
        return result
    }

    func appendSnapshots(followers: [User]) {
        let snapshot = Snapshot(context: context)
        snapshot.date = Date()
        snapshot.followers = followers
        try? context.save()
    }
    
    // MARK: - Users
    
    func loadFollowing() -> [User] {
        var result = [User]()

        userStateGet { (following, _) in
            result = following
        }
        
        return result
    }
    
    func saveFollowing(users: [User]) {
        userStateSet(following: users, followed: nil)
    }
    
    func loadFollowed() -> [User] {
        var result = [User]()

        userStateGet { (_, followed) in
            result = followed
        }
        
        return result
    }
    
    func saveFollowed(users: [User]) {
        userStateSet(following: nil, followed: users)
    }
    
    // MARK: - Users (Helper methods)
    
    fileprivate func userStateGet(completion: (_ following: [User], _ followed: [User]) -> Void) {
        let request = UserState.fetchRequest() as NSFetchRequest<UserState>

        do {
            let userState = try context.fetch(request)
            if userState.count == 0 {
                createDefaultUserState()
            } else {
                let state = userState[0]
                completion(state.following!, state.followed!)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    fileprivate func userStateSet(following: [User]?, followed: [User]?) {
        let request = UserState.fetchRequest() as NSFetchRequest<UserState>

        do {
            let userState = try context.fetch(request)
            if userState.count == 0 {
                createDefaultUserState()
            } else {
                if following != nil {
                    userState[0].following = following
                }
                if followed != nil {
                    userState[0].followed = followed
                }

                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    fileprivate func createDefaultUserState() {
        let state = UserState(context: context)
        state.followed = [User]()
        state.following = [User]()
        try? context.save()
    }

    // MARK: - Statistics
    
    func loadFollowedStatistic() -> [Statistic] {
        var result = [Statistic]()
        
        statisticGet(statisticType: StatisticType.followed) { (statistic) in
            result = statistic
        }
        
        return result
    }
    
    func appendFollowedStatistic(count: Int) {
        let statistic = Statistic(context: context)
        statistic.date = Date()
        statistic.count = Int64(count)
        statistic.type = StatisticType.followed.rawValue
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFollowingStatistic() -> [Statistic] {
        var result = [Statistic]()
        
        statisticGet(statisticType: StatisticType.following) { (statistic) in
            result = statistic
        }
        
        return result
    }
    
    func appendFollowingStatistic(count: Int) {
        let statistic = Statistic(context: context)
        statistic.date = Date()
        statistic.count = Int64(count)
        statistic.type = StatisticType.following.rawValue
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Statistics (Helper methods)
    
    fileprivate func statisticGet(statisticType: StatisticType, completion: ((_ statistic: [Statistic]) -> Void)) {
        let request = Statistic.fetchRequest() as NSFetchRequest<Statistic>
        let predicate = NSPredicate(format: "type == %@", argumentArray: [statisticType.rawValue])
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            completion(result)
        } catch {
            print(error.localizedDescription)
        }
    }
}
