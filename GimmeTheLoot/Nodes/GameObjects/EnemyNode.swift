//
//  EnemyNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//
import SpriteKit

public class EnemyNode: SKSpriteNode {
    
    public static func newInstance() -> EnemyNode {
        let node = EnemyNode(texture: nil,
                             color: .red,
                              size: CGSize(width: 70,
                                           height: 100))
        node.name = "enemy"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        
        //TO DO
        // ADD colision and testcontact bit masks
        
        return node
    }
}
