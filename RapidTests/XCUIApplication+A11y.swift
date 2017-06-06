//
//  XCUIApplication+A11y.swift
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

import XCTest
import Nimble
import RapidA11y
import Foundation

public extension XCUIApplication {
    /**
     * func uncheckedElementFor
     * checks the controlName and grabs the reference for that XCUIElement.
     * This is "unchecked", in that it has not been "waited" upon and is not necessarily there.
     */
    func uncheckedElementFor(_ control: NSObject) -> XCUIElement {
        let query = control.accessibilityControlInformation.type.xcElementQueryForControl(self)
        return query[control.accessibilityProperties.identifier]
    }

    /**
     * func elementFor
     * input: NSObject -- control desired to see if it exists within current XCUIApplication accessibility hiearchy
     * output: XCUIElement -- A11y XCUIElement for the control.
     * Note: Test will wait for element to be present up to 30 seconds, and will also wait for the element to be tappable.
     * Test will FAIL if element is not present and tappable after timeout (default:30).
     */
    @discardableResult
    public func elementFor(_ control: NSObject, andTimeout timeout: TimeInterval = 30) -> XCUIElement {
        let element = uncheckedElementFor(control)
        expect(element).toNot(beNil())
        wait(withTimeout: timeout, for: element.isHittable)
        expect(element.isHittable).to(beTrue())
        return element
    }

    /**
     * func elementExistsFor
     * input: 
     *  NSObject -- control desired to check if it exists
     *  TimeInterval -- timeout, default:10
     * output:
     *  Bool -- does the element exist or not
     */
    @discardableResult
    public func elementExistsFor(_ control: NSObject, andTimeout timeout: TimeInterval = 10) -> Bool {
        let element = uncheckedElementFor(control)
        wait(withFailureAssertion: false, withTimeout: timeout, for: element.exists)
        return element.exists
    }

    /**
     * func elementHittable
     * input:
     *  XCUIElement -- element desired to check if it exists
     *  TimeInterval -- timeout, default:10
     * output:
     *  Bool -- can the test harness currently tap this element
     */
    @discardableResult
    public func elementHittable(_ element: XCUIElement, andTimeout timeout: TimeInterval = 10) -> Bool {
        wait(withFailureAssertion: false, withTimeout: timeout, for: element.isHittable)
        return element.isHittable
    }

    func wait(_ timeout: TimeInterval, andQueue queue: DispatchQueue, withCondition  condition: @escaping (()->Bool)) -> Bool {
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
            XCTAssertTrue(wait(timeout, andQueue: queue){ condition() })
            return nil
        } else {
            return wait(timeout, andQueue: queue){ condition() }
        }
    }
}
