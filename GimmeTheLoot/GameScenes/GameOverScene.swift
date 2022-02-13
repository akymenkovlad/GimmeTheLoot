//
//  LoseScene.swift
//  GimmeTheLoot
//
//  Created by Vlad Akymenko on 11.02.2022.
//

import SpriteKit

class GameOverScene: SKScene {
    
    weak var transitionDelegate: TransitionDelegate?
    
    private var retryButton: SKSpriteNode!
    private var goToLevelsMenuButton: SKSpriteNode!
    
    init(size: CGSize, won:Bool) {
        super.init(size: size)
        
        backgroundColor = SKColor.white
        
        let message = won ? "You Won!" : "You Lose :["
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 3.0),
            SKAction.run() { [weak self] in
                // 5
                guard let self = self else { return }
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene = LevelScene(size: size, level: 2)
                scene.transitionDelegate = self.transitionDelegate
                self.view?.presentScene(scene, transition:reveal)
            }
        ]))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
