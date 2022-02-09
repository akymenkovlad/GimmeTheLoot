//
//  PlayerNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit

public class PlayerNode: SKSpriteNode {
    
    public static func newInstance() -> PlayerNode {
        let node = PlayerNode(texture: nil,
                              color: .blue,
                              size: CGSize(width: 70,
                                           height: 100))
        node.name = "player"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Player
        
        //TO DO
        // ADD colision and testcontact bit masks
        
        return node
    }
}
