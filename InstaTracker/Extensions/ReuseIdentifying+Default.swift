//
//  ReuseIdentifying+Default.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 26.11.2020.
//

import Foundation

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
