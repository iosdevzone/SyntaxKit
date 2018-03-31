//
//  Theme.swift
//  SyntaxKit
//
//  Created by Sam Soffes on 10/11/14.
//  Copyright © 2014-2015 Sam Soffes. All rights reserved.
//

import Foundation
import X

#if !os(OSX)
	import UIKit
#endif

public typealias Attributes = [NSAttributedStringKey: AnyObject]

public struct Theme {

	// MARK: - Properties

	public let UUID: String
	public let name: String
	public let attributes: [String: Attributes]


	// MARK: - Initializers

	public init?(dictionary: [String: AnyObject]) {
		guard let UUID = dictionary["uuid"] as? String,
			let name = dictionary["name"] as? String,
			let rawSettings = dictionary["settings"] as? [[String: AnyObject]]
			else { return nil }

		self.UUID = UUID
		self.name = name

		var attributes = [String: Attributes]()
		for raw in rawSettings {
			guard let scopes = raw["scope"] as? String else { continue }
			guard var setting = raw["settings"] as? [String: AnyObject] else { continue }

            
            if let value = setting.removeValue(forKey: "foreground") as? String {
				setting[NSAttributedStringKey.foregroundColor.rawValue] = Color(hex: value)
			}

            if let value = setting.removeValue(forKey: "background") as? String {
				
                setting[NSAttributedStringKey.backgroundColor.rawValue] = Color(hex: value)
			}

			// TODO: caret, invisibles, lightHighlight, selection, font style
            var attrs = Attributes()
            for (k,v) in setting {
                attrs[NSAttributedStringKey(k)] = v
            }
            
            for scope in scopes.components(separatedBy: ",") {
                let key = scope.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
				attributes[key] = attrs
			}
		}
		self.attributes = attributes
	}
}
