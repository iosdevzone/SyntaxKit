//
//  AttributedParser.swift
//  SyntaxKit
//
//  Created by Sam Soffes on 9/24/14.
//  Copyright © 2014-2015 Sam Soffes. All rights reserved.
//


public class AttributedParser: Parser {
	
	// MARK: - Types
	
	public typealias AttributedCallback = (/* scope: */ String, /* range: */ NSRange, /* attributes: */ Attributes?) -> Void
	
	
	// MARK: - Properties
	
	public let theme: Theme
	
	
	// MARK: - Initializers
	
	public required init(language: Language, theme: Theme) {
		self.theme = theme
		super.init(language: language)
	}
	
	
	// MARK: - Parsing
	
	public func parse(_ string: String, match callback: AttributedCallback) {
		parse(string) { scope, range in
			callback(scope, range, self.attributesForScope(scope))
		}
	}
	
	public func attributedStringForString(string: String, baseAttributes: Attributes? = nil) -> NSAttributedString {
		let output = NSMutableAttributedString(string: string, attributes: baseAttributes)
		parse(string) { _, range, attributes in
			if let attributes = attributes{
				output.addAttributes(attributes, range: range)
			}
		}
		return output
	}
	
	
	// MARK: - Private
	
	private func attributesForScope(_ scope: String) -> Attributes? {
		let components = scope.components(separatedBy: ".")// as NSArray
		let count = components.count
		if count == 0 {
			return nil
		}
		
		var attributes = Attributes()
		for i in stride(from:components.count, to:0, by: -1) {
			let key = components[0..<i].joined(separator: ".")
			if let attrs = theme.attributes[key] {
				for (k, v) in attrs {
					attributes[k] = v
				}
			}
		}
		
		if attributes.isEmpty {
			return nil
		}
		
		return attributes
	}
}
