//
//  PlayerNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit

public class PlayerNode: SKSpriteNode {
    
    private let walkingActionKey = "walking_action"
    
    private let walkFrames: [SKTexture] = [
        SKTexture(imageNamed: "player_2"),
        SKTexture(imageNamed: "player_3"),
        SKTexture(imageNamed: "player_4"),
        SKTexture(imageNamed: "player_5"),
        SKTexture(imageNamed: "player_6"),
        SKTexture(imageNamed: "player_7"),
        SKTexture(imageNamed: "player_8"),
        SKTexture(imageNamed: "player_9"),
        SKTexture(imageNamed: "player_10")
    ]
    private(set) var isMovingRight = true
    private(set) var isMoving = false
    private let movementSpeed: CGFloat = 150
    
    public static func newInstance(with size: CGSize) -> PlayerNode {
        let node = PlayerNode(texture: SKTexture(imageNamed: "player"),
                              color: .blue,
                              size: CGSize(width: size.width,
                                           height: size.height))
        node.name = "player"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2, center: CGPoint(x: 0, y: -size.width * 0.3))
        node.physicsBody?.density = 100
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.categoryBitMask = PhysicsCategory.Player
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Pin | PhysicsCategory.GameFrame | PhysicsCategory.Enemy | PhysicsCategory.Acid | PhysicsCategory.Platform
        return node
    }
    
    public func updatePosition() {
        if isMoving {
            if action(forKey: walkingActionKey) == nil {
                let walkingAction = SKAction.repeatForever(
                    SKAction.animate(with: walkFrames,
                                     timePerFrame: 0.1,
                                     resize: false,
                                     restore: true))
                run(walkingAction, withKey:walkingActionKey)
            }
            if isMovingRight {
                //Move right
                physicsBody?.velocity.dx = movementSpeed
                xScale = 1
            } else {
                //Move left
                physicsBody?.velocity.dx = -movementSpeed
                xScale = -1
            }
        } else {
            if action(forKey: walkingActionKey) != nil {
                removeAction(forKey: walkingActionKey)
            }
        }
        
    }
    public func changeDirection() {
        isMovingRight = !isMovingRight
    }
    public func startMovement() {
        isMoving = !isMoving
    }
}
