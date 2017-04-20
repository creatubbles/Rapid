//
//  A11y.swift
//  Creatubbles Explorer
//
//  Created by Benjamin Hendricks on 21/03/2017.
//  Copyright © 2017 Creatubbles. All rights reserved.
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
                case is UIBarButtonItem:
                    viewConfig = addControlType(.barButtonItem, newControl: control, toConfig: viewConfig)
                case is UIButton:
                    viewConfig = addControlType(.button, newControl: control, toConfig: viewConfig)
                case is UITextField:
                    viewConfig = addControlType(.textField, newControl: control, toConfig: viewConfig)
                case is UICollectionView:
                    viewConfig = addControlType(.collectionView, newControl: control, toConfig: viewConfig)
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
