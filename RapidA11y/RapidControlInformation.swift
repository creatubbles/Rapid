//
//  AccessibilityControlType.swift
//
//  Copyright 2017 Creatubbles
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
//  persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
//  Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

public struct RapidControlInformation: Hashable {
    public static let viewIdentifierSuffix: String = "_view_a11yID"

    public var identifier: String {
        get {
            return "\(type)_\(index)_control_a11yID"
        }
    }

    public var label: String {
        get {
            return "\(type)_\(index)_control_a11yLabel"
        }
    }

    public var hint: String {
        get {
            return "\(type)_\(index)_control_a11yHint"
        }
    }

    public var index: Int = 0
    public var rapidType: accessibilityControlType = .any
    public var traits: UIAccessibilityTraits = UIAccessibilityTraitNone
    public var type: NSObject.Type

    public var hashValue: Int {
        return identifier.hash
    }

    init(type: NSObject.Type) {
        self.type = type
    }
}

public func ==(lhs: RapidControlInformation, rhs: RapidControlInformation) -> Bool {
    return lhs.identifier == rhs.identifier
}
