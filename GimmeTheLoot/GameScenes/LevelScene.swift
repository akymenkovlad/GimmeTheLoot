//
//  Level1Scene.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

class LevelScene: BaseGameScene {
    
    private var currentLevel: Int!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view) //
        print("moved")
        print(currentLevel)    }
}
