//
//  Playing.swift
//  GimmeTheLoot
//
//  Created by Valados on 14.03.2022.
//

import SpriteKit
import GameplayKit

class Playing: GKState {
    unowned let scene: LevelScene
    
    init(scene: SKScene) {
        self.scene = scene as! LevelScene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Tutorial.Type
    }
    
}
