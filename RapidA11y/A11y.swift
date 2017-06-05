//
//  A11y.swift
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

public protocol StringRawRepresentable: RawRepresentable {
    typealias RawValue = String
}

public protocol A11yViewFactoryProtocol {
    associatedtype Control: StringRawRepresentable
    associatedtype View: StringRawRepresentable

    func view(for view: View) -> A11yView<Control, View>?
}

public class A11y<Control, View> where Control: StringRawRepresentable, View: StringRawRepresentable {

    public required init() {}

    /**
     * controls array should represent view controls in top/bottom left/right arrangement, where origin of view is always considered in cases of "ties".
     */
    @discardableResult
    public func addA11yIdentifiersForControls<T: A11yViewFactoryProtocol, UIA11yControl: UIAccessibilityIdentification>(_ controls: [UIA11yControl], inView view: UIView, withA11yViewName viewName: View, forFactory factory: T) -> Bool {
        var viewConfig = [A11yControlType: [UIA11yControl]]()
        for control in controls {
            switch control {
            case is UIActivityIndicatorView:
                viewConfig = addControlType(.activityIndicator, newControl: control, toConfig: viewConfig)
            case is UIAlertController:
                viewConfig = addControlType(.alert, newControl: control, toConfig: viewConfig)
            case is UIBarButtonItem:
                viewConfig = addControlType(.barButtonItem, newControl: control, toConfig: viewConfig)
            case is UIButton:
                viewConfig = addControlType(.button, newControl: control, toConfig: viewConfig)
            case is UITableViewCell:
            case is UICollectionViewCell:
                viewConfig = addControlType(.cell, newControl: control, toConfig: viewConfig)
            case is UICollectionView:
                viewConfig = addControlType(.collectionView, newControl: control, toConfig: viewConfig)
            case is UIDatePicker:
                viewConfig = addControlType(.datePicker, newControl: control, toConfig: viewConfig)
            case is UIImageView:
                viewConfig = addControlType(.image, newControl: control, toConfig: viewConfig)
            case is UILabel:
                viewConfig = addControlType(.label, newControl: control, toConfig: viewConfig)
            case is UINavigationBar:
                viewConfig = addControlType(.navigationBar, newControl: control, toConfig: viewConfig)
            case is UIScrollView:
                viewConfig = addControlType(.scrollView, newControl: control, toConfig: viewConfig)
            case is UISearchBar:
                viewConfig = addControlType(.searchField, newControl: control, toConfig: viewConfig)
            case is UISwitch:
                viewConfig = addControlType(.`switch`, newControl: control, toConfig: viewConfig)
            case is UITabBar:
                viewConfig = addControlType(.tabBar, newControl: control, toConfig: viewConfig)
            case is UITabBarItem:
                viewConfig = addControlType(.tabBarItem, newControl: control, toConfig: viewConfig)
            case is UITableView:
                viewConfig = addControlType(.table, newControl: control, toConfig: viewConfig)
            case is UITextView:
                viewConfig = addControlType(.textView, newControl: control, toConfig: viewConfig)
            case is UITextField:
                viewConfig = addControlType(.textField, newControl: control, toConfig: viewConfig)
            case is UIToolbar:
                viewConfig = addControlType(.toolbar, newControl: control, toConfig: viewConfig)
            case is UIWebView:
                viewConfig = addControlType(.webView, newControl: control, toConfig: viewConfig)
            default:
                viewConfig = addControlType(.any, newControl: control, toConfig: viewConfig)
            }
        }

        guard T.Control.self == Control.self, T.View.self == View.self,
            let viewName = viewName as? T.View,
            let a11yView = factory.view(for: viewName) else {
            return false
        }

        if !A11yView.configureUIView(view, forA11yView: a11yView, uiViewConfig: viewConfig) {
            assertionFailure("A11y Failed to load properly")
            return false
        }

        return true
    }

    func addControlType<UIA11yControl: UIAccessibilityIdentification>(_ controlType: A11yControlType, newControl: UIA11yControl, toConfig config:  [A11yControlType: [UIA11yControl]]) -> [A11yControlType: [UIA11yControl]] {
        var configCopy = config
        if var existingControls = configCopy[controlType] {
            existingControls.append(newControl)
            configCopy[controlType] = existingControls
        } else {
            configCopy[controlType] = [newControl]
        }
        return configCopy
    }
}
