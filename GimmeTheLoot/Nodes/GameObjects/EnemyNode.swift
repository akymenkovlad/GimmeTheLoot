//
//  EnemyNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//
import SpriteKit

public class EnemyNode: SKSpriteNode {
    
    private let walkingActionKey = "walking_action"
    
    private let walkFrames: [SKTexture] = []
    private(set) var isMovingRight = true
    private(set) var isMoving = false
    private let movementSpeed: CGFloat = 200
    private var isStatic = true
    
    public static func newInstance(with size: CGSize) -> EnemyNode {
        let node = EnemyNode(texture: nil,
                             color: .red,
                             size: CGSize(width: size.width,
                                          height: size.height))
        node.name = "enemy"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Pin | PhysicsCategory.GameFrame | PhysicsCategory.Prize | PhysicsCategory.Boulder
        
        return node
    }
    
    public func updatePosition() {
        if isMoving {
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
    }
    public func changeDirection() {
        isMovingRight = !isMovingRight
    }
    
    public func startMovement() {
        isMoving = !isMoving
    }
}
