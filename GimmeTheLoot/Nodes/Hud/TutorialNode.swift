//
//  TutorialNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 22.02.2022.
//

import SpriteKit

class TutorialNode : SKNode {
    
    private var levelLabel: SKLabelNode!
    private var background: SKShapeNode!
    private var image: SKSpriteNode!
    
    //Setup hud here
    public func setup(with size:CGSize) {
        self.name = "tutorial"
        levelLabel = SKLabelNode(fontNamed: "Krungthep")
        levelLabel.text = ""
        levelLabel.numberOfLines = 5
        levelLabel.fontSize = 25
        levelLabel.fontColor = SKColor.white
        levelLabel.zPosition = 1010
        levelLabel.horizontalAlignmentMode = .center
        levelLabel.verticalAlignmentMode = .center
        addChild(levelLabel)
        
        background = SKShapeNode(rectOf: size)
        background.fillColor = .black
        background.strokeColor = .black
        background.zPosition = 1010
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.alpha = 0.8
        addChild(background)
        
    }
    
    func setTutorial(in level: Int, _ size: CGSize) {
        switch level {
        case 1:
            levelLabel.text =
            """
                    How to Play
            Swipe pin to remove it
            
            
            
            
            Tap on player to
            start/stop movement
                        
                        
            
            
            Good luck :)
            """
            let margin = (size.height - levelLabel.frame.height) / 10
            levelLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.5)
            
            image = SKSpriteNode(texture: SKTexture(imageNamed: "pin"),
                                       size: CGSize(width: size.width * 0.12, height: size.width * 0.5))
            image.zRotation = CGFloat.pi / 2
            image.position = CGPoint(x: size.width / 2, y: size.height / 2 + image.size.width + margin)
            image.zPosition = 1020
            addChild(image)
            
            let playerImage = SKSpriteNode(texture: SKTexture(imageNamed: "player"),
                                           size: CGSize(width: size.width / 5, height: size.width / 4))
            playerImage.position = CGPoint(x: size.width / 2, y: size.height / 2 - playerImage.size.height - margin)
            playerImage.zPosition = 1010
            addChild(playerImage)
        case 2:
            levelLabel.text = "Avoid acid!"
            levelLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
            levelLabel.fontSize = 30
            
            let acidnode = SKEmitterNode(fileNamed: "Acid")!
            acidnode.particlePositionRange = CGVector(dx: 150, dy: 50)
            acidnode.zPosition = 1010
            acidnode.position = CGPoint(x: size.width / 2, y: size.height * 0.5)
            addChild(acidnode)
        case 3:
            levelLabel.text =
        """
        Use platform
        to get
        the treasure
        """
            levelLabel.position = CGPoint(x: size.width / 2 , y: size.height * 0.7)
            image = SKSpriteNode(texture: SKTexture(imageNamed: "platform"), size: CGSize(width: 210, height: 70))
            image.position = CGPoint(x: size.width / 2, y: size.height / 2)
            image.zPosition = 1010
            addChild(image)
        case 4:
            levelLabel.text =
        """
        Don't get caught
        by enemy!
        """
            levelLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
            
            image = SKSpriteNode(texture: SKTexture(imageNamed: "enemy"), size: CGSize(width: 100, height: 150))
            image.position = CGPoint(x: size.width / 2, y: size.height / 2)
            image.zPosition = 1010
            addChild(image)
        default:
            break
        }
    }
}
