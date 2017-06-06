//
//  UIViewController+Rapid.swift
//  RapidA11y
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
    public var accessibilityProperties: (identifier: String, rapidType: A11yControlType, traits: UIAccessibilityTraits, label: String, hint: String) {
        get {
            return (identifier: "\(description)_control_a11yID", rapidType: accessibilityControlInformation.type, traits: accessibilityControlInformation.traits, label: "\(description)_control_a11yLabel", hint: "\(description)_control_a11yHint")
        }
    }
}

extension UIViewController: RapidIdentifiable {
    public var viewAccessibilityIdentifier: String {
        get {
            return "\(type(of: self).description)_view_a11yID"
        }
    }

    public var accessibilityControls: [NSObject] {
        get {
            return view.subviews
        }
    }

    public var controlAccessibilityProperties: [NSObject: (identifier: String, rapidType: A11yControlType, traits: UIAccessibilityTraits, label: String, hint: String)] {
        get {
            var properties = [NSObject: (identifier: String, rapidType: A11yControlType, traits: UIAccessibilityTraits, label: String, hint: String)]()
            accessibilityControls.forEach {
                control in
                properties[control] = control.accessibilityProperties
            }
            return properties
        }
    }

//    func configureView() {
//        for control as RapidIdentifiableControl in accessibilityControls {
//            let properties = controlAccessibilityProperties[control]
//            control.accessibilityIdentifier = properties.identifier
//            control.accessibilityTraits = properties.traits
//            control.accessibilityLabel = properties.label
//            control.accessibilityHint = properites.hint
//        }
//    }
//
//    func configureRapid() {
//        for control as RapidIdentifiableControl in accessibilityControls {
//            let properties = (identifier: String, rapidType: A11yControlType, traits: UIAccesibilityTraits, label: String, hint: String)
//        }
//    }
}
