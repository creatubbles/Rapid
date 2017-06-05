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

public extension A11yControlType {
    public func xcElementQueryForControl(_ app: XCUIApplication) -> XCUIElementQuery {
        switch self {
        case .activityIndicator:
            return app.activityIndicators
        case .alert:
            return app.alerts
        case .any:
            return app.descendants(matching: .any)
        case .button:
            return app.buttons
        case .cell:
            return app.cells
        case .collectionView:
            return app.collectionViews
        case .datePicker:
            return app.datePickers
        case .image:
            return app.images
        case .label:
            return app.staticTexts
        case .navigationBar:
            return app.navigationBars
        case .scrollView:
            return app.scrollViews
        case .searchField:
            return app.searchFields
        case .`switch`:
            return app.switches
        case .tabBar:
            return app.tabBars
        case .table:
            return app.tables
        case .textField:
            return app.textFields
        case .textView:
            return app.textViews
        case .toolbar:
            return app.toolbars
        case .webView:
            return app.webViews
        default:
            return app.descendants(matching: .any)
        }
    }
}
