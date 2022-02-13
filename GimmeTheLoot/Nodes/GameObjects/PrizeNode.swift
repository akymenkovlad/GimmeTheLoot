//
//  MoneyNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

public class PrizeNode: SKSpriteNode {
    
    public static func newInstance() -> PrizeNode {
        let node = PrizeNode(texture: nil,
                                color: .green,
                                size: CGSize(width: 70,
                                             height: 50))
        node.name = "prize"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Prize
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        //TO DO
        // ADD colision and testcontact bit masks
        
        return node
    }
}
