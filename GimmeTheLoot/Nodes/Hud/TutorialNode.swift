//
//  TutorialNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 22.02.2022.
//

import SpriteKit

class TutorialNode : SKNode {
    
    private var levelLabel: SKLabelNode!
    
    //Setup hud here
    public func setup() {
        self.name = "tutorial"
        levelLabel = SKLabelNode(fontNamed: "Krungthep")
        levelLabel.text = ""
        levelLabel.numberOfLines = 10
        levelLabel.fontSize = 20
        levelLabel.fontColor = SKColor.white
        addChild(levelLabel)
    }
    
    func setTextForLabel(in level: Int, _ size: CGSize) {
        switch level {
        case 1:
            levelLabel.text = """
        1. Swipe on pin to
        move the obstacle
        2. Tap on player to
        start/stop movement
        3. Take the treasure
        """
            levelLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.65)
        case 2:
            levelLabel.text = """
        Avoid acid!
        """
            levelLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.3)
        case 3:
            levelLabel.text = """
        Use platform
        to get
        the treasure
        """
            levelLabel.position = CGPoint(x: size.width * 0.7 , y: size.height * 0.4)
        case 4:
            levelLabel.text = """
        Don't get caught by enemy!
        """
            levelLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.35)
        default:
            break
        }
    }
}
