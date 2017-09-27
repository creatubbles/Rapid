//
//  ViewController.swift
//  RapidDemo
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

import RapidA11y
import UIKit

class ViewController: UIViewController, RapidAccessible {
    @IBOutlet weak private var buttonA: UIButton!
    @IBOutlet weak private var buttonB: UIButton!
    @IBOutlet weak private var buttonC: UIButton!
    @IBOutlet weak private var buttonD: UIButton!

    static func rapidControlsInformation() -> [RapidControlInformation] {
        var buttonInfo = UIButton.accessibilityProperties
        return Array(0...3).map { index in
            buttonInfo.index = index
            return buttonInfo
        }
    }

    public func rapidAccessibilityControls() -> [NSObject] {
        return [buttonA, buttonB, buttonC, buttonD]
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        applyAccessibility()
    }
}
