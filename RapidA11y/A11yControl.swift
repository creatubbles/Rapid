//
//  A11yControl.swift
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


public class A11yControl<Control>: A11yBaseControl where Control: StringRawRepresentable {
    var controlName: Control

    override public var a11yControlName: String {
        /*
         Force unwrap is ok here, because `StringRawRepresentable` always
         has a string as it's value, and a crash if it's not is acceptable.
         */
        return self.controlName.rawValue as! String
    }

    private var a11yControlTypeInternal: A11yControlType
    override public var a11yControlType: A11yControlType {
        return a11yControlTypeInternal
    }

    public init(_ name: Control, type: A11yControlType) {
        self.controlName = name
        self.a11yControlTypeInternal = type
        super.init()
    }
}

public func ==<Control: StringRawRepresentable>(lhs: A11yControl<Control>, rhs: A11yControl<Control>) -> Bool {
    return lhs.a11yControlName == rhs.a11yControlName && lhs.a11yControlType == rhs.a11yControlType
}

public func !=<Control>(lhs: A11yControl<Control>, rhs: A11yControl<Control>) -> Bool {
    return !(lhs==rhs)
}
