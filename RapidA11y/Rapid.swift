//
//  Rapid.swift
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

import UIKit

/**
 * protocol RapidIdentifiable
 * 
 * Use:
 * Implement on view controllers that contain 1+ controls
 *
 * Info:
 * Define your accessibility views as compositions of controls
 * Implement this protocol in your view controllers, giving
 * each view controller "scene" a `rapidAccessibilityIdentifier`
 * as well as a set of `Control`s. These are the elements visisble
 * in this composite "scene".
 */
public protocol RapidIdentifiable {
    associatedtype Control: RapidControlIdentifiable
    var rapidAccessibilityIdentifier: String { get }
    var accessibilityControls: Set<Control> { get }
    func applyAccessibility()
}

/**
 * protocol RapidControlIdentifiable
 *
 * Use: 
 * Implement on classes of controls.
 * 
 * Info:
 * Controls are currently best generically thought of as NSObjects that are visible
 * to the accessibility engine. They are specified by a tuple of a couple items,
 * which are all defaulted to sane values in all situations, but can be always
 * overridden to achieve custom VoiceOver behavior and increase testability.
 */
public protocol RapidControlIdentifiable: Hashable {
    var accessibilityProperties: (identifier: String, rapidType: accessibilityControlType, traits: UIAccessibilityTraits, label: String, hint: String) { get set }
    func applyProperties()
}
