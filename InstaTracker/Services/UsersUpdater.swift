//
//  UsersUpdater.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 30.11.2020.
//

import Foundation
import SwiftyInsta

class UsersUpdater {
    private let instagram: Instagram
    private let group = DispatchGroup()

    var errorCompletion: (Error) -> Void = { _ in }

    init(instagram: Instagram) {
        self.instagram = instagram
    }

    func updateFollowersAndFollowing(completion: @escaping () -> Void){
        group.enter()
        instagram.handler.users.following(
                user: .me,
                with: .init(maxPagesToLoad: .max),
                updateHandler: nil,
                completionHandler: self.followingCompletion
        )

        group.enter()
        instagram.handler.users.followed(
                byUser: .me,
                usersMatchinQuery: nil,
                with: .init(maxPagesToLoad: .max),
                updateHandler: nil,
                completionHandler: self.followedCompletion
        )

        group.notify(queue: .main) {
            completion()
        }
    }

    private func followingCompletion(result: Result<[SwiftyInsta.User], Error>, page: PaginationParameters) -> () {
        do {
            let following = try result.get()

            let preparedFollowing = following.map(convertToUser)

            self.storeWhoLeft(preparedFollowing: preparedFollowing)
            
            Storage.shared.appendFollowingStatistic(count: following.count)
            Storage.shared.saveFollowing(users: preparedFollowing)

            group.leave()
        } catch {
            errorCompletion(error)
        }
    }

    private func followedCompletion(result: Result<[SwiftyInsta.User], Error>, page: PaginationParameters) -> () {
        do {
            let followed = try result.get()

            let preparedFollowed = followed.map(convertToUser)

            Storage.shared.appendFollowedStatistic(count: followed.count)
            Storage.shared.saveFollowed(users: preparedFollowed)

            group.leave()
        } catch {
            errorCompletion(error)
        }
    }

    private func convertToUser(user: SwiftyInsta.User) -> User {
        User(username: user.username, name: user.name ?? "", picture: user.thumbnail, isPrivate: user.isPrivate)
    }

    private func storeWhoLeft(preparedFollowing: [User]) {
        let previousFollowing = Storage.shared.loadFollowing()
        let calculator = DiffCalculator()
        let whoLeft = calculator.diffState(newState: preparedFollowing, oldState: previousFollowing)

        if whoLeft.count > 0 {
            Storage.shared.appendSnapshots(followers: whoLeft)
        }
    }
}
