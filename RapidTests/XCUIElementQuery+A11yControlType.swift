//
//  XCUIElementQuery+A11yControlType.swift
//  Pods
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

import Foundation
import XCTest
import RapidA11y

public extension XCUIApplication {
    public func elementInViewForControl(_ viewIdentifier: String, controlType: accessibilityControlType) -> XCUIElementQuery {
        return descendants(matching: .any)[viewIdentifier].descendants(matching: .any).queryForControlType(controlType)
    }
}

public extension XCUIElementQuery {
    public func queryForControlType(_ controlType: accessibilityControlType) -> XCUIElementQuery {
        switch controlType {
        case .activityIndicator:
            return activityIndicators
        case .alert:
            return alerts
        case .any:
            return descendants(matching: .any)
        case .button:
            return buttons
        case .cell:
            return cells
        case .collectionView:
            return collectionViews
        case .datePicker:
            return datePickers
        case .image:
            return images
        case .label:
            return staticTexts
        case .navigationBar:
            return navigationBars
        case .scrollView:
            return scrollViews
        case .searchField:
            return searchFields
        case .secureTextField:
            return secureTextFields
        case .`switch`:
            return switches
        case .tabBar:
            return tabBars
        case .table:
            return tables
        case .textField:
            return textFields
        case .textView:
            return textViews
        case .toolbar:
            return toolbars
        case .webView:
            return webViews
        default:
            return descendants(matching: .any)
        }
    }
}
