//
//  ForumateTests.swift
//  ForumateTests
//
//  Created by Kyle on 2023/5/21.
//

import XCTest
@testable import Forumate

final class ForumateTests: XCTestCase {
    func testReplaceHTMLLink() throws {
        let input = #"""
        Hello <a href="example.com">label</a> World
        """#
        let expectedOutput = #"""
        Hello [label](example.com) World
        """#
        XCTAssertEqual(input.replacingHTMLLink(), expectedOutput)
    }
}
