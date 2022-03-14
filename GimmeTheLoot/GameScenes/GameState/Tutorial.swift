//
//  Tutorial.swift
//  GimmeTheLoot
//
//  Created by Valados on 14.03.2022.
//

import SpriteKit
import GameplayKit

class Tutorial: GKState {
    unowned let scene: LevelScene
    
    init(scene: SKScene) {
        self.scene = scene as! LevelScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        scene.tutorial.run(.fadeIn(withDuration: 0.5))
    }
    
    override func willExit(to nextState: GKState) {
        if nextState is Playing {
            self.scene.tutorial.run(.fadeOut(withDuration: 0.5))
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Playing.Type
    }
    
}
