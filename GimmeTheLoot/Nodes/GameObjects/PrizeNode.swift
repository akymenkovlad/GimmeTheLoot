//
//  MoneyNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

public class PrizeNode: SKSpriteNode {
    
    public static func newInstance(with size: CGSize) -> PrizeNode {
        let node = PrizeNode(texture: nil,
                             color: .green,
                             size: CGSize(width: size.width,
                                          height: size.height))
        node.name = "prize"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Prize
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        node.physicsBody?.collisionBitMask = PhysicsCategory.Ground | PhysicsCategory.Pin | PhysicsCategory.GameFrame
        node.physicsBody?.restitution = 0
        
        return node
    }
}
