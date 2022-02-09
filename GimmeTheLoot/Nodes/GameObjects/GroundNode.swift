//
//  GroundNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

public class GroundNode: SKSpriteNode {
    
    public static func newInstance() -> GroundNode {
        let node = GroundNode(texture: nil,
                              color: .blue,
                              size: CGSize(width: 70,
                                           height: 100))
        node.name = "ground"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsCategory.Ground
        //TO DO
        // ADD colision and testcontact bit masks
        
        return node
    }
}
