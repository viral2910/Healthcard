//
//  XIBed.swift
//  Finest 50
//
//  Created by Pratik on 20/01/22.
//

import Foundation
import UIKit

public protocol XIBed {
    static func instantiate() -> Self
}

public extension XIBed where Self: UIViewController {
    static func instantiate() -> Self {
        return Self(nibName: String(describing: self), bundle: Bundle(for: Self.self))
    }
}
