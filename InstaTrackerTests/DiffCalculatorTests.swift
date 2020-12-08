//
//  DiffCalculatorTests.swift
//  InstaTrackerTests
//
//  Created by Alex Morkovkin on 25.11.2020.
//

import XCTest
@testable import InstaTracker

class DiffCalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print("setUpWithError")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("tearDownWithError")
    }

    func testDiffCalculation1() throws {
        let calc = DiffCalculator()

        let old = [
            User(username: "user1", name: "user1", picture: nil, isPrivate: false),
            User(username: "user2", name: "user2", picture: nil, isPrivate: false),
            User(username: "user3", name: "user3", picture: nil, isPrivate: false),
            User(username: "user11", name: "user11", picture: nil, isPrivate: false)
        ]

        let new = [
            User(username: "user2", name: "user2", picture: nil, isPrivate: false),
            User(username: "user3", name: "user3", picture: nil, isPrivate: false),
            User(username: "user4", name: "user4", picture: nil, isPrivate: false),
        ]

        let result = calc.diffState(newState: new, oldState: old)
        
        XCTAssertTrue(result.count == 2)
        
        let first = result[0]
        XCTAssertEqual(first.name, "user1")
        XCTAssertEqual(first.username, "user1")
        XCTAssertEqual(first.picture, nil)
        
        let second = result[1]
        XCTAssertEqual(second.name, "user11")
        XCTAssertEqual(second.username, "user11")
        XCTAssertEqual(second.picture, nil)
    }
    

    func testDiffCalculationEmpty() throws {
        let calc = DiffCalculator()

        var old = [User]()
        var new = [User]()
        
        for i in 1...1000 {
            old.append(User(username: "user\(i)", name: "user\(i)", picture: nil, isPrivate: false))
            new.append(User(username: "user\(i)", name: "user\(i)", picture: nil, isPrivate: false))
        }

        let result = calc.diffState(newState: new, oldState: old)
        XCTAssertEqual(result.count, 0)
    }

    func testDiffCalculationEmptyHighLoad() throws {

        self.measure {
            try! testDiffCalculationEmpty()
        }
    }
    
    func testInBothEqual() {
        let calc = DiffCalculator()
        
        let left = [
            User(username: "user1", name: "user1", picture: nil, isPrivate: false),
            User(username: "user2", name: "user2", picture: nil, isPrivate: false),
            User(username: "user3", name: "user3", picture: nil, isPrivate: false)
        ]
        
        let right = [
            User(username: "user1", name: "user1", picture: nil, isPrivate: false),
            User(username: "user2", name: "user2", picture: nil, isPrivate: false),
            User(username: "user3", name: "user3", picture: nil, isPrivate: false)
        ]
        
        let result = calc.common(newState: left, oldState: right)
        XCTAssertEqual(result.count, 3)
    }
    
    func testInBothNotFullyEqual() {
        let calc = DiffCalculator()
        
        let left = [
            User(username: "user0", name: "user0", picture: nil, isPrivate: false),
            User(username: "user2", name: "user2", picture: nil, isPrivate: false),
            User(username: "user3", name: "user3", picture: nil, isPrivate: false)
        ]
        
        let right = [
            User(username: "user1", name: "user1", picture: nil, isPrivate: false),
            User(username: "user2", name: "user2", picture: nil, isPrivate: false),
            User(username: "user4", name: "user4", picture: nil, isPrivate: false),
            User(username: "user3", name: "user3", picture: nil, isPrivate: false),
        ]
        
        let result = calc.common(newState: left, oldState: right)
        XCTAssertEqual(result.count, 2)

        let first = result[0]
        let second = result[1]
        
        XCTAssertEqual(first.name, "user2")
        XCTAssertEqual(second.name, "user3")
    }

}
