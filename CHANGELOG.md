# CHANGELOG
## Note: Will eventually be automated by fastlane, but manual updates for now!
## Note 2: Keep this document's max column width to 80 characters! Thank you :) 

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