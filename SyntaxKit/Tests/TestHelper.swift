//
//  TestHelper.swift
//  SyntaxKit
//
//  Created by Sam Soffes on 6/15/15.
//  Copyright © 2015 Sam Soffes. All rights reserved.
//

import Foundation
import XCTest
import X
@testable import SyntaxKit

func fixture(_ name: String, _ type: String) -> String! {
    let path = Bundle(for: LanguageTests.self).path(forResource: name, ofType: type)!
    return try! String(contentsOfFile: path)
}

func fixture(name: String, _ type: String) -> String! {
    let path = Bundle(for: LanguageTests.self).path(forResource: name, ofType: type)!
	return try! String(contentsOfFile: path)
}

/// Loads a tmLanguage file from the [Class] Bundle.
func language(_ name: String) -> Language {
    return language(name:name)
}

func language(name: String) -> Language! {
    let path = Bundle(for: LanguageTests.self).path(forResource: name, ofType: "tmLanguage")!
    guard let plist = NSDictionary(contentsOfFile: path)! as? [String: AnyObject] else { fatalError() }
	return Language(dictionary: plist)!
}

func theme(name: String) -> Theme! {
    let path = Bundle(for: LanguageTests.self).path(forResource: name, ofType: "tmTheme")!
	let plist = NSDictionary(contentsOfFile: path)! as [NSObject: AnyObject]
    return Theme(dictionary: plist as! [String : AnyObject])!
}

func simpleTheme() -> Theme! {
	return Theme(dictionary: [
        "uuid": "7" ,
        "name": "Simple" ,
		"settings": [
			[
				"scope": "entity.name",
				"settings": [
					"color": "blue"
				]
			],
			[
				"scope": "string",
				"settings": [
					"color": "red"
				]
			],
			[
				"scope": "constant.numeric",
				"settings": [
					"color": "purple"
				]
			]
		]
		] as [String: AnyObject])
}

func assertEqualColors(color1: Color, _ color2: Color, accuracy: CGFloat = 0.005) {
    // This was originally XCTAssertEqualWithAccuracy, which is deprecated
    // switch to suggested XCTAssertEqual, but may need to revisit if issues arise.
	XCTAssertEqual(color1.redComponent, color2.redComponent)
	XCTAssertEqual(color1.greenComponent, color2.greenComponent)
	XCTAssertEqual(color1.blueComponent, color2.blueComponent)
	XCTAssertEqual(color1.alphaComponent, color2.alphaComponent)
}

//extension NSRange: Equatable { }
//
//public func ==(lhs: NSRange, rhs: NSRange) -> Bool {
//    return lhs.location == rhs.location && lhs.length == rhs.length
//}
