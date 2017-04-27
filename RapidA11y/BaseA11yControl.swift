//
//  BaseA11yControl.swift
//  Creatubbles
//
//  Created by Benjamin Hendricks on 21/03/2017.
//  Copyright © 2017 Creatubbles. All rights reserved.
//

protocol A11yControlIdentifiable {
    var a11yControlName: String { get }
    var a11yControlType: A11yControlType { get }
}

open class A11yBaseControl: A11yControlIdentifiable {
    open var a11yControlName: String {
        return "" // to override
    }

    open var a11yControlType: A11yControlType {
        return .any // to override
    }
    
    private let identifierSuffix = "_a11y_identifier"

    public lazy var identifier: String = {
        return "\(self.a11yControlName)\(self.identifierSuffix)"
    }()

    public init() { /** no-op */ }
}
