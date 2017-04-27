//
//  XCUIApplication+A11y.swift
//  Creatubbles
//
//  Created by Benjamin Hendricks on 13/03/2017.
//  Copyright © 2017 Creatubbles. All rights reserved.
//
//
//  XCUIApplication+A11y.swift
//  Creatubbles
//
//  Created by Benjamin Hendricks on 3/7/17.
//  Copyright © 2017 Creatubbles. All rights reserved.
//

import XCTest
import Nimble
import RapidA11y
import Foundation

public extension XCUIApplication {
    // MARK: - Core A11y to XCTestCase hooks
    /**
     * func uncheckedElementFor
     * checks the controlName and grabs the reference for that XCUIElement.
     * This is "unchecked", in that it has not been "waited" upon and is not necessarily there.
     */
    func uncheckedElementFor(_ control: A11yBaseControl) -> XCUIElement {
        let query = control.a11yControlType.xcElementQueryForControl(self)
        return query[control.identifier]
    }

    /**
     * func elementFor
     * input: A11yControlName -- control name desired to see if exists within current XCUIApplication A11y hiearchy
     * output: XCUIElement -- A11y XCUIElement for the control.
     * Note: Test will wait for element to be present up to 30 seconds, and will also wait for the element to be tappable.
     * Test will FAIL if element is not present and tappable after 30 second timeout (first 30 sec for present, then another 30 for tappable).
     */
    @discardableResult
    public func elementFor(_ control: A11yBaseControl) -> XCUIElement {
        let element = uncheckedElementFor(control)
        expect(element).toNot(beNil())
        wait(withTimeout: 30, for: element.isHittable)
        expect(element.isHittable).to(beTrue())
        return element
    }

    @discardableResult
    public func elementExistsFor(_ control: A11yBaseControl) -> Bool {
        let element = uncheckedElementFor(control)
        wait(withFailureAssertion: false, withTimeout: 10, for: element.exists)
        return element.exists
    }

    func waitForConditionOnQueueWithTimeout(_ timeout: TimeInterval, AndQueue queue: DispatchQueue, WithCondition  condition: @escaping (()->Bool)) -> Bool {
        // Based on http://bou.io/CTTRunLoopRunUntil.html
        var fulfilled = false

        let beforeWaiting: ((_ observer: CFRunLoopObserver?, _ activity: CFRunLoopActivity?) -> Void)! = {
            observer, activity in
            // The run loop should be stopped after the condition is fulfilled (CFRunLoopStop below)
            assert(!fulfilled)
            // Check the condition
            fulfilled = condition()
            // Condition fulfilled: stop RunLoop now
            if fulfilled {
                CFRunLoopStop(CFRunLoopGetCurrent())
            }
        }

        // We add a timer dispatch source here to make sure that we wake up at least every 0.x seconds
        // in case we're waiting for a condition that does not necessarily wake up the run loop.
        let timer: DispatchSourceTimer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: 0), queue: queue)
        timer.scheduleRepeating(deadline: .now(), interval: .milliseconds(100))
        timer.setEventHandler(handler: {
            // purposeful no-op
        })
        if #available(iOS 10.0, *) {
            timer.activate()
        } else {
            timer.resume()
        }

        let newObserver = CFRunLoopObserverCreateWithHandler(nil, CFRunLoopActivity.beforeWaiting.rawValue, true, 0, beforeWaiting)
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), newObserver, CFRunLoopMode.defaultMode)
        CFRunLoopRunInMode(CFRunLoopMode.defaultMode, timeout, false)
        CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), newObserver, CFRunLoopMode.defaultMode)

        timer.cancel()
        // If we haven't fulfilled the condition yet, test one more time before returning. This avoids
        // that we fail the test just because we somehow failed to properly poll the condition, e.g. if
        // the run loop didn't wake up.
        if (!fulfilled) {
            fulfilled = condition()
        }

        return fulfilled
    }

    /**
     * func wait
     * Waits on a CFRunLoop through the `TestWaitHelper` helper for a boolean condition passed in as a closure.
     * These condition can be any closure that returns a boolean.
     */
    @discardableResult
    @nonobjc public func wait(withFailureAssertion assertIfFailure: Bool = true, withTimeout timeout: TimeInterval, for condition: @autoclosure @escaping (Void) -> Bool) -> Bool? {
        let queue = DispatchQueue.global(qos: .userInteractive)
        if assertIfFailure {
            XCTAssertTrue(waitForConditionOnQueueWithTimeout(timeout, AndQueue: queue){ condition() })
            return nil
        } else {
            return waitForConditionOnQueueWithTimeout(timeout, AndQueue: queue){ condition() }
        }
    }
}
