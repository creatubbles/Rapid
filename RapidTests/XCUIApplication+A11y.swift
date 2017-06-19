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

import Foundation
import RapidA11y
import XCTest

public extension XCUIApplication {

    @discardableResult
    public func elementsForControlType(_ type: AccessibilityControlType, matching: NSObject.Type) -> [XCUIElement] {
        let query = descendants(matching: .any).queryForControlType(type)
        let allElementsMatchingQuery = query.allElementsBoundByAccessibilityElement
        let matches: [XCUIElement] = allElementsMatchingQuery.filter { element in
            return element.identifier.contains("\(matching)")
        }
        return matches
    }

    @discardableResult
    public func elementForIdentifier(_ identifier: String, withTimeout timeout: TimeInterval = 10) -> XCUIElement {
        let element = descendants(matching: .any)[identifier]
        wait(withTimeout: 0.5, for: element.exists)
        wait(withTimeout: timeout, for: element.isHittable)
        XCTAssert(element.isHittable, "Element was not hittable after timeout time, error occurred.")
        return element
    }

    @discardableResult
    public func elementExistsForIdentifier(_ identifier: String, withTimeout timeout: TimeInterval = 10) -> Bool {
        let element = descendants(matching: .any)[identifier]
        wait(withTimeout: timeout, for: element.exists)
        return element.exists
    }

    @discardableResult
    public func elementHittable(_ element: XCUIElement, andTimeout timeout: TimeInterval = 10) -> Bool {
        wait(withTimeout: timeout, for: element.isHittable)
        return element.isHittable
    }

    func wait(_ timeout: TimeInterval, andQueue queue: DispatchQueue, withCondition  condition: @escaping (() -> Bool)) -> Bool {
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
        if !fulfilled {
            fulfilled = condition()
        }

        return fulfilled
    }

    /**
     * func wait
     * Waits on a CFRunLoop through the `TestWaitHelper` helper for a boolean condition passed in as a closure.
     * These condition can be any closure that returns a boolean.
     */
    @discardableResult @nonobjc
    public func wait(withTimeout timeout: TimeInterval, for condition: @autoclosure @escaping () -> Bool) -> Bool? {
        let queue = DispatchQueue.global(qos: .userInteractive)
            return wait(timeout, andQueue: queue) { condition() }
    }
}
