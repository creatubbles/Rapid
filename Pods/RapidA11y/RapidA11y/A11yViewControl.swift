//
//  A11yViewControl.swift
//  Creatubbles Explorer
//
//  Created by Benjamin Hendricks on 21/03/2017.
//  Copyright © 2017 Creatubbles. All rights reserved.
//

public class A11yViewControl<View>: A11yBaseControl where View: StringRawRepresentable {
    var view: View

    override public var a11yControlName: String {
        return self.view.rawValue
    }

    override public var a11yControlType: A11yControlType {
        return .any
    }
    
    public init(_ view: View) {
        self.view = view
        super.init()
    }
}
