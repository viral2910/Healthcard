//
//  CACornerMask.swift
//  Level
//
//  Created by Pratik on 13/12/21.
//

import Foundation
import UIKit

extension CACornerMask {
    public static var topLeft: CACornerMask     = .layerMinXMinYCorner//{ get }
    public static var topRight: CACornerMask    = .layerMaxXMinYCorner //{ get }
    public static var bottomLeft: CACornerMask  = .layerMinXMaxYCorner //{ get }
    public static var bottomRight: CACornerMask = .layerMaxXMaxYCorner //{ get }
}
