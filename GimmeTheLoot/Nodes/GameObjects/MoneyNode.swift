//
//  MoneyNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

public class MoneyNode: SKNode {
    
    public static func newInstance() -> MoneyNode {
        let container = MoneyNode()
        
        for _ in 0...10 {
            let node = SKSpriteNode(texture: nil,
                                    color: .green,
                                    size: CGSize(width: 30,
                                                 height: 15))
            node.name = "money"
            node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.height / 2)
            node.physicsBody?.categoryBitMask = PhysicsCategory.Money
            //TO DO
            // ADD colision and testcontact bit masks
            container.addChild(node)
        }
        container.name = "prize"
        
        return container
    }
}
