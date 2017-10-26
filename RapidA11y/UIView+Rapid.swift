//
//  UIView+Rapid.swift
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

protocol RapidViewIdentifiable {
    func applyViewAccessibility()
}

extension UIView: RapidViewIdentifiable {
    // Make sure to call this in `awakeFromNib()` or anywhere
    // that makes sense after your UI is set up
    public func applyViewAccessibility() {
        guard let accessibleSelf = self as? RapidAccessible else {
            return
        }
        let selfType = type(of: accessibleSelf)
        // This will get overridden by a scope value if 'self' view is in controls array.
        // Provides default fallback if not.
        self.accessibilityIdentifier = "\(selfType)\(RapidControlInformation.viewIdentifierSuffix)"
        let controlsInformation: [RapidControlInformation] = selfType.rapidControlsInformation()
        let controls: [NSObject] = accessibleSelf.rapidAccessibilityControls()
        guard controlsInformation.count == controls.count else {
            assertionFailure("Mismatch on number of controls given to Rapid")
            return
        }

        _ = controls.enumerated().map { index, control in
            control.applyProperties(controlsInformation[index])
        }
    }
}
