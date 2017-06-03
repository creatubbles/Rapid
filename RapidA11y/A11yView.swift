//
//  A11yView.swift
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
