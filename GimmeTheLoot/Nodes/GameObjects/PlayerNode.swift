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
    private let movementSpeed: CGFloat = 100
    
    public static func newInstance() -> PlayerNode {
        let node = PlayerNode(texture: nil,
                              color: .blue,
                              size: CGSize(width: 70,
                                           height: 100))
        node.name = "player"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Player
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Pin | PhysicsCategory.GameFrame
        
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
