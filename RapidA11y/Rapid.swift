//
//  Rapid.swift
//  Creatubbles Explorer
//
//  Created by Benjamin Hendricks on 21/03/2017.
//  Copyright © 2017 Creatubbles. All rights reserved.
//

public protocol RapidProtocol {
    associatedtype C: StringRawRepresentable
    associatedtype V: StringRawRepresentable

    func a11y() -> A11y<C, V>
}
