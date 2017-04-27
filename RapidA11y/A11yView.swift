//
//  A11yView.swift
//  Creatubbles
//
//  Created by Benjamin Hendricks on 21/03/2017.
//  Copyright © 2017 Creatubbles. All rights reserved.
//
import UIKit

public typealias A11yViewConfig<Control> = [A11yControlType: [Control]]
public class A11yView<Control, View> where Control: StringRawRepresentable, View: StringRawRepresentable {
    public let viewName: View
    public let config: A11yViewConfig<Control>

    public init(viewName: View, config: A11yViewConfig<Control>) {
        self.viewName = viewName
        self.config = config
    }

    /**
     * configureUIView is an internal method to assign A11y identifiers to views based on an A11yViewConfig setup.
     * We grab the A11yViewConfig from the passed in a11yView, and match up (using the defined order)
     * control configurations with actual `UIControl`s from the main app process, to assign those `UIControl`s
     * the correct accessibility identifiers.
     * 
     * This method returns the success of the configuration, where failure can occur if:
     *  - The uiViewConfig and a11yViewConfig don't match up (in terms of number of elements for any control type)
     * The method also sets the A11yID of the view itself that contains the UIControls (which is the UIView passed in).
     */
    public static func configureUIView<UIA11yControl: UIAccessibilityIdentification>(_ view: UIView, forA11yView a11yView: A11yView<Control, View>, uiViewConfig: [A11yControlType: [UIA11yControl]]) -> Bool {
        let a11yViewControl = A11yViewControl<View>(a11yView.viewName)
        view.accessibilityIdentifier = a11yViewControl.identifier
        let config = a11yView.config
        for controlType in uiViewConfig.keys {
            let uiControlsOptional = uiViewConfig[controlType]
            let a11yControlsOptional = config[controlType]

            guard let uiControls = uiControlsOptional,
                let a11yControls = a11yControlsOptional,
                uiControls.count == a11yControls.count else {
                    return false
            }

            for (index, control) in uiControls.enumerated() {
                let a11yControl = a11yControls[index]
                control.accessibilityIdentifier = A11yControl(a11yControl, type: controlType).identifier
            }
        }
        return true
    }
}
