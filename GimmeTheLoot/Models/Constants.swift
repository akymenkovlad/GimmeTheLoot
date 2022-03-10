//
//  Constants.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import Foundation
import SpriteKit

let MuteKey = "MUTED"
let NumberOfLevels = 30

struct PhysicsCategory {
    static let Player: UInt32 = 0x1 << 1
    static let GameFrame: UInt32 = 0x1 << 2
    static let Pin: UInt32 = 0x1 << 3
    static let Enemy: UInt32 = 0x1 << 4
    static let Prize: UInt32 = 0x1 << 5
    static let Ground: UInt32 = 0x1 << 6
    static let Acid: UInt32 = 0x1 << 7
    static let Box: UInt32 = 0x1 << 8
    static let Boulder: UInt32 = 0x1 << 9
    static let Platform: UInt32 = 0x1 << 10
}

public enum Directions {
    case left
    case right
    case up
    case down
}
