//
//  NSObject+Rapid.swift
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

extension NSObject: RapidControlIdentifiable {
    public static var accessibilityProperties: RapidControlInformation {
        get {
            return RapidControlInformation(type: self)
        }
    }

    @discardableResult
    public func applyProperties(_ controlTag: Int = 0, classOverride controlType: NSObject.Type? = nil) -> RapidControlInformation {
        let selfType = controlType ?? type(of: self)
        var properties = selfType.accessibilityProperties
        properties.index = controlTag
        properties.type = selfType
        
        // only 3 controls supported by UIAccessibilityIdentification
        if let identifiableViewSelf = self as? UIView {
            identifiableViewSelf.accessibilityIdentifier = properties.identifier
        } else if let identifiableBarItemSelf = self as? UIBarItem {
            identifiableBarItemSelf.accessibilityIdentifier = properties.identifier
        } else if let identifiableImageSelf = self as? UIImage {
            identifiableImageSelf.accessibilityIdentifier = properties.identifier
        }

        accessibilityHint = properties.hint
        accessibilityLabel = properties.label
        accessibilityTraits = properties.traits
        return properties
    }
}
