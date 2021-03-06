//
//  AttributedParserTests.swift
//  SyntaxKitTests
//
//  Created by Sam Soffes on 9/19/14.
//  Copyright © 2014-2015 Sam Soffes. All rights reserved.
//

import XCTest
import SyntaxKit

class AttributedParserTests: XCTestCase {

	// MARK: - Properties

	let parser = AttributedParser(language: language("YAML"), theme: simpleTheme())


	// MARK: - Tests

	func testParsing() {
        let string = parser.attributedStringForString(string: "title: Hello World\ncount: 42\n")

        XCTAssertEqual(["color": "blue"] as NSDictionary, string.attributes(at: 0, effectiveRange: nil) as NSDictionary)
        XCTAssertEqual(["color": "red"] as NSDictionary, string.attributes(at: 7, effectiveRange: nil) as NSDictionary)
        XCTAssertEqual(["color": "blue"] as NSDictionary, string.attributes(at: 19, effectiveRange: nil) as NSDictionary)
        XCTAssertEqual(["color": "purple"] as NSDictionary, string.attributes(at: 25, effectiveRange: nil) as NSDictionary)
	}
}
