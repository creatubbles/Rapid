# CHANGELOG
## Note: Will eventually be automated by fastlane, but manual updates for now!
## Note 2: Keep this document's max column width to 80 characters! Thank you :) 

##### v 1.1.0:
- Update for Xcode 9 and Swift 4, still baseline to iOS 10.

##### v 1.0.10:
- No major changes it seems, nothing to report.

##### v 1.0.9:
- Remove dependency on Nimble & Quick. While Rapid is named and inspired by 
Quick&Nimble, it was just not necessary in these two pods.

##### v 1.0.8:
- Small change to wait method, removing `waitWithAssertion` ability,
since it wasn't working anyways.

##### v 1.0.7:
- Continuing rapid improvements across the board
- Sample integration with Creatubbles project revealed
several places to improve, and these have been greatly enhanced.

##### v 1.0.6:
- Huge internal changes to RapidA11y to greatly simplify it's integration
- Accompanying deletion of README steps which are now irrelevant
- Bringing demo app into the picture to show off how to use RapidA11y
- WWDC 2017! Dropping iOS 9 support preemptively, iOS 10+ only for Rapid.

##### v 1.0.5:
- Re-insert `secureTextField` control type query helper

##### v 1.0.4:
- Re-insert `secureTextField` control type and add custom switch cases to gauge
if a certain UITextField has `secureTextEntry` on or not.
- New method added to wait for hittability, used like this:
```
let app = XCUIApplication()
// timeout is an optional param, defaulting to 10 seconds
// result of `elementHittable` is discardable
let isHittable: Bool = app.elementHittable(controlThatExists, andTimeout: 15)
```

##### v 1.0.3:
- Fix mapping of control types in RapidTests, so as to use fixes from 1.0.1
in RapidA11y

##### v 1.0.2:
- Bump version number because of mismanaged version update for 1.0.1

##### v 1.0.1:
- Small update, but add all control type support to RapidA11y view
configurator. Before, only a limited number of control types actually were
configurable.  

##### v 1.0.0:
- First release of Rapid under MIT license, distributed as 2 frameworks
(RapidA11y and RapidTests)
- Still many chunks of functionality missing, but core ability to add
identifiers to some controls and use them in tests works
- Up next: more complete API definition, framework tests,
automated deployment of framework with Fastlane

##### pre v. 1.0.0:
- Initial development, pre-release and unsupported. Any issues with non 1.0.0+
versions please just upgrade :)
