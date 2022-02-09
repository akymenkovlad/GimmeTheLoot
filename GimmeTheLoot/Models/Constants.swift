//
//  Constants.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import Foundation
import SpriteKit

let MuteKey = "MUTED"

struct PhysicsCategory {
    static let Player: UInt32 = 0x1 << 1
    static let GameFrame: UInt32 = 0x1 << 2
    static let Pin: UInt32 = 0x1 << 3
    static let Enemy: UInt32 = 0x1 << 4
    static let Money: UInt32 = 0x1 << 5
    static let Ground: UInt32 = 0x1 << 5
    static let Acid: UInt32 = 0x1 << 5
}

public enum PinDirections {
    case left
    case right
    case up
    case down
}
