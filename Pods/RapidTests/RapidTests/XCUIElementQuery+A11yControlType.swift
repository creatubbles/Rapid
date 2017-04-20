//
//  XCUIElementQuery+A11yControlType.swift
//  Pods
//
//  Created by Benjamin Hendricks on 3/25/17.
//
//

import RapidA11y
import XCTest

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
        case .keyboard:
            return app.keyboards
        case .navigationBar:
            return app.navigationBars
        case .searchField:
            return app.searchFields
        case .secureTextField:
            return app.secureTextFields
        case .scrollView:
            return app.scrollViews
        case .staticText:
            return app.staticTexts
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
