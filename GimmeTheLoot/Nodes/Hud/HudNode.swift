//
//  HudNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit

class HudNode : SKNode {
    private var menuButton: SKSpriteNode!
    private let menuButtonTexture = SKTexture(imageNamed: "quit_button")
    var menuButtonAction: (() -> ())?
    
    private var restartButton: SKSpriteNode!
    private let restartButtonTexture = SKTexture(imageNamed: "restart_level_button")
    var restartButtonAction: (() -> ())?
    
    private var levelLabel: SKLabelNode!
    
    private var backgroundNode: SKSpriteNode!
    
    //Setup hud here
    public func setup(size: CGSize) {
        
        let margin : CGFloat = 15
        
        menuButton = SKSpriteNode(texture: menuButtonTexture)
        menuButton.size = CGSize(width: 30,
                                 height: 30)
        menuButton.position = CGPoint(x: menuButton.size.width / 2 + margin,
                                      y: size.height - menuButton.size.height - margin)
        menuButton.zPosition = 1000
        
        restartButton = SKSpriteNode(texture: restartButtonTexture)
        restartButton.size = CGSize(width: 30,
                                    height: 30)
        restartButton.position = CGPoint(x: size.width - restartButton.size.width / 2 - margin ,
                                         y: size.height - restartButton.size.height - margin)
        restartButton.zPosition = 1000
        
        levelLabel = SKLabelNode(fontNamed: "Krungthep")
        levelLabel.text = "Level"
        levelLabel.fontSize = 30
        levelLabel.fontColor = SKColor.white
        levelLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 + size.width * 0.75 - 30  + levelLabel.fontSize )
        
        backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "background_2"), size: size)
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgroundNode.zPosition = -1000
        
        addChild(levelLabel)
        addChild(menuButton)
        addChild(backgroundNode)
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

