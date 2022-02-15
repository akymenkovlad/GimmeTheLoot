//
//  PlayerNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit

public class PlayerNode: SKSpriteNode {
    
    private let walkingActionKey = "walking_action"
    
    private let walkFrames: [SKTexture] = []
    private(set) var isMovingRight = true
    private(set) var isMoving = false
    private let movementSpeed: CGFloat = 150
    
    public static func newInstance() -> PlayerNode {
        let node = PlayerNode(texture: nil,
                              color: .blue,
                              size: CGSize(width: 50,
                                           height: 50))
        node.name = "player"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.categoryBitMask = PhysicsCategory.Player
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Pin | PhysicsCategory.GameFrame | PhysicsCategory.Enemy | PhysicsCategory.Acid
        
        //TO DO
        // ADD colision and testcontact bit masks
        return node
    }
    
    public func updatePosition() {
//            if action(forKey: walkingActionKey) == nil {
//                let walkingAction = SKAction.repeatForever(
//                    SKAction.animate(with: walkFrames,
//                                     timePerFrame: 0.1,
//                                     resize: false,
//                                     restore: true))
//                run(walkingAction, withKey:walkingActionKey)
//            }
            if isMovingRight {
                //Move right
                physicsBody?.velocity.dx = movementSpeed
                xScale = -1
            } else {
                //Move left
                physicsBody?.velocity.dx = -movementSpeed
                xScale = 1
            }
    }
    public func changeDirection() {
        isMovingRight = !isMovingRight
    }
    public func startMovement() {
        isMoving = !isMoving
    }
}
