//
//  ThemeTests.swift
//  SyntaxKit
//
//  Created by Sam Soffes on 6/15/15.
//  Copyright © 2015 Sam Soffes. All rights reserved.
//

import XCTest
import X
@testable import SyntaxKit

class ThemeTests: XCTestCase {

	// MARK: - Properties

    let tomorrow = theme(name: "Tomorrow")


	// MARK: - Tests

	func testLoading() {
		XCTAssertEqual("82CCD69C-F1B1-4529-B39E-780F91F07604", tomorrow!.UUID)
		XCTAssertEqual("Tomorrow", tomorrow!.name)
        let attrs = tomorrow!.attributes["constant.other"]!
        assertEqualColors(color1: Color(hex: "#666969")!,
                          attrs[NSAttributedStringKey.foregroundColor] as! Color)
      
	}
}
