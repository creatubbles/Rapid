//
//  A11yControlType.swift
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

public enum A11yControlType {
    case activityIndicator
    case alert
    case any
    case barButtonItem
    case button
    case cell
    case collectionView
    case datePicker
    case image
    case label
    case navigationBar
    case scrollView
    case searchField
    case secureTextField
    case `switch`
    case tabBar
    case tabBarItem
    case table
    case textView
    case textField
    case toolbar
    case webView
}

extension NSObject {
    public var accessibilityControlInformation: (type: A11yControlType, traits: UIAccessibilityTraits) {
        switch self {
        case is UIActivityIndicatorView:
            return (.activityIndicator, UIAccessibilityTraitNone)
        case is UIAlertController:
            return (.alert, UIAccessibilityTraitNone)
        case is UIBarButtonItem:
            return (.barButtonItem, UIAccessibilityTraitButton)
        case is UIButton:
            return (.button, UIAccessibilityTraitButton)
        case is UITableViewCell, is UICollectionViewCell:
            return (.cell, UIAccessibilityTraitNone)
        case is UICollectionView:
            return (.collectionView, UIAccessibilityTraitNone)
        case is UIDatePicker:
            return (.datePicker, UIAccessibilityTraitNone)
        case is UIImageView:
            return (.image, UIAccessibilityTraitImage)
        case is UILabel:
            return (.label, UIAccessibilityTraitStaticText)
        case is UINavigationBar:
            return (.navigationBar, UIAccessibilityTraitNone)
        case is UIScrollView:
            return (.scrollView, UIAccessibilityTraitNone)
        case is UISearchBar:
            return (.searchField, UIAccessibilityTraitSearchField)
        case is UISwitch:
            return (.`switch`, UIAccessibilityTraitButton)
        case is UITabBar:
            return (.tabBar, UIAccessibilityTraitTabBar)
        case is UITabBarItem:
            return (.tabBarItem, UIAccessibilityTraitButton)
        case is UITableView:
            return (.table, UIAccessibilityTraitNone)
        case is UITextView:
            return (.textView, UIAccessibilityTraitNone)
        case let textField as UITextField where textField.isSecureTextEntry:
            return (.secureTextField, UIAccessibilityTraitNone)
        case let textField as UITextField where !textField.isSecureTextEntry:
            return (.textField, UIAccessibilityTraitNone)
        case is UIToolbar:
            return (.toolbar, UIAccessibilityTraitNone)
        case is UIWebView:
            return (.webView, UIAccessibilityTraitNone)
        default:
            return (.any, UIAccessibilityTraitNone)
        }
    }
}
