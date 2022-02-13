//
//  HudNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit

class HudNode : SKNode {
    private var menuButton : SKSpriteNode!
    private let menuButtonTexture = SKTexture(imageNamed: "quit_button")
    var menuButtonAction : (() -> ())?
    
    private var restartButton : SKSpriteNode!
    private let restartButtonTexture = SKTexture(imageNamed: "quit_button")
    var restartButtonAction : (() -> ())?
    
    private var levelLabel : SKLabelNode!
    
    //Setup hud here
    public func setup(size: CGSize) {
        
        let margin : CGFloat = 15
        
        menuButton = SKSpriteNode(texture: menuButtonTexture)
        menuButton.size = CGSize(width: 30,
                                 height: 30)
        menuButton.position = CGPoint(x: size.width - menuButton.size.width / 2 - margin,
                                      y: size.height - menuButton.size.height / 2 - margin)
        menuButton.zPosition = 1000
        
        restartButton = SKSpriteNode(texture: restartButtonTexture)
        restartButton.size = CGSize(width: 30,
                                    height: 30)
        restartButton.position = CGPoint(x: menuButton.position.x - (menuButton.size.width + restartButton.size.width + 10) / 2,
                                         y: size.height - restartButton.size.height / 2 - margin)
        restartButton.zPosition = 1000
        
        levelLabel = SKLabelNode(fontNamed: "Chalkduster")
        levelLabel.text = "Level"
        levelLabel.fontSize = 30
        levelLabel.fontColor = SKColor.white
        levelLabel.position = CGPoint(x: size.width / 2, y: size.height - 50 - levelLabel.fontSize )
        
        addChild(levelLabel)
        addChild(menuButton)
        addChild(restartButton)
    }

    func touchBeganAtPoint(point: CGPoint) {
        if menuButton.contains(point) && menuButtonAction != nil {
            menuButtonAction!()
        } else if restartButton.contains(point) && restartButtonAction != nil {
            restartButtonAction!()
        }
    }
    func setTextForLabel(_ text: String) {
        levelLabel.text = text
    }
}

