//
//  EnemyNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//
import SpriteKit

public class EnemyNode: SKSpriteNode {
    
    private let walkingActionKey = "walking_action"
    private let attackActionKey = "attacking_action"
    
    private let walkFrames: [SKTexture] = [
        SKTexture(imageNamed: "enemy_2"),
        SKTexture(imageNamed: "enemy_3"),
        SKTexture(imageNamed: "enemy_4"),
        SKTexture(imageNamed: "enemy_5"),
        SKTexture(imageNamed: "enemy_6"),
        SKTexture(imageNamed: "enemy_7"),
        SKTexture(imageNamed: "enemy_8"),
        SKTexture(imageNamed: "enemy_9"),
        SKTexture(imageNamed: "enemy_10"),
        SKTexture(imageNamed: "enemy_11"),
        SKTexture(imageNamed: "enemy_12"),
        SKTexture(imageNamed: "enemy_13")
    ]
    private let attackFrames: [SKTexture] = [
        SKTexture(imageNamed: "attack_1"),
        SKTexture(imageNamed: "attack_2"),
        SKTexture(imageNamed: "attack_3"),
        SKTexture(imageNamed: "attack_4"),
        SKTexture(imageNamed: "attack_5"),
        SKTexture(imageNamed: "attack_6"),
        SKTexture(imageNamed: "attack_7")
    ]
    private(set) var isMovingRight = true
    private(set) var isMoving = false
    private let movementSpeed: CGFloat = 200
    private var isStatic = true
    
    public static func newInstance(with size: CGSize) -> EnemyNode {
        let node = EnemyNode(texture: SKTexture(imageNamed: "enemy"),
                             color: .red,
                             size: CGSize(width: size.width,
                                          height: size.height))
        node.name = "enemy"
        node.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2, center: CGPoint(x: 0, y: -size.width * 0.3))
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.restitution = 0
        node.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Pin | PhysicsCategory.GameFrame | PhysicsCategory.Prize | PhysicsCategory.Boulder
        
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
//            if action(forKey: attackActionKey) == nil {
//                let attackAction = SKAction.repeatForever(
//                    SKAction.animate(with: attackFrames,
//                                     timePerFrame: 0.2,
//                                     resize: false,
//                                     restore: true))
//                run(attackAction, withKey:attackActionKey)
//            }
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
