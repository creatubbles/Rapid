![RapidA11y & RapidTests powered by Creatubbles](Resources/bannerCreatubbles.png)

[![RapidTests CocoaPod](https://img.shields.io/cocoapods/v/RapidTests.svg)](https://cocoapods.org/pods/RapidTests)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/creatubbles/Rapid/blob/master/LICENSE.md)
[![RapidTests Platforms](https://img.shields.io/cocoapods/p/RapidTests.svg)](https://cocoapods.org/pods/RapidTests)

Rapid is a UI test development framework for Swift (and Objective-C soon!).
Inspired by [Quick](https://github.com/Quick/quick) and [Nimble](https://github.com/Quick/Nimble).

## Installation
##### Cocoapods

Sample `Podfile`:

```
platform :ios, '10.0'
use_frameworks!

def test_pods
    # define test pod imports
    pod 'RapidTests', '1.0.10'
end

abstract_target 'Common' do
    # other common target pods here   
    pod 'RapidA11y', '1.0.10'

    # app target which picks up RapidA11y pod and any other common pods
    target 'Example' do 
    end

    # test target gets RapidTests pod added (+ Quick/Nimble)
    # it still does get RapidA11y and common pods as well. 
    target 'ExampleUITests' do
        test_pods 
    end
end

```

With the `RapidA11y` (A11y is for Accessibility, A-(11 letters)-y) pod being needed for common app targets (whichever ones will have access to elements that need to be made visible to the testing harness)

With the `RapidTests` pod being needed only in test targets (mainly the UI test target, to be specific).

Once `Podfile` setup for your project, run `$ pod install` in the directory of your Podfile ([Troubleshooting help for this step from CocoaPods](https://guides.cocoapods.org/using/troubleshooting.html))

## Setup

SUPER SIMPLE 5 STEP PROCESS:

1) Install pod - accessibility pod for application targets, test pod for test targets
2) Implement the `RapidAccessible` protocol for views you want Rapid to have access to, and don't forget to
specify `accessibilityControls` defined by the `RapidIdentifiable` protocol. 
3) Call `applyAccessibility()` in `viewDidLoad()` of view controllers implementing `RapidAccessible`.
4) Get VoiceOver for free and easy testability of your code immediately! :bulb::unlock:
5) Profit :tada::tada::tada:

Example simplicity (fully accessible view controller with colored buttons):
```
class ViewController: UIViewController, RapidAccessible {
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!

    static func rapidControlsInformation() -> Array<RapidControlInformation> {
        var buttonInfo = UIButton.accessibilityProperties
        return Array(0...3).map {
            index in
            buttonInfo.index = index
            return buttonInfo
        }
    }

    public override var accessibilityControls: Array<NSObject> {
        get {
            return [buttonA, buttonB, buttonC, buttonD]
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        applyAccessibility()
    }
}

```

## Questions?

Please visit [our FAQ](./FAQ.md) to see all commonly asked questions and their answers.

## Changelog

To see what we've changed in the past, check out [our Changelog](./CHANGELOG.md).

## License
#### MIT License

Copyright 2017 Creatubbles

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

See also the [`LICENSE`](LICENSE.md) file for details.
