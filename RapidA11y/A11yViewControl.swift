//
//  A11yViewControl.swift
//  Creatubbles
//
//  Created by Benjamin Hendricks on 21/03/2017.
//  Copyright © 2017 Creatubbles. All rights reserved.
//

public class A11yViewControl<View>: A11yBaseControl where View: StringRawRepresentable {
    var view: View

    override public var a11yControlName: String {
        /* 
        Force unwrap is ok here, because `StringRawRepresentable` always
        has a string as it's value, and a crash if it's not is acceptable.
        */
        return self.view.rawValue as! String
    }

    override public var a11yControlType: A11yControlType {
        return .any
    }
    
    public init(_ view: View) {
        self.view = view
        super.init()
    }
}
