//
//  AcidNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

public class AcidNode: SKShapeNode {
    
    public static func newInstance() -> AcidNode {
        let size = CGSize(width: 100,height: 30)
        let node = AcidNode(rectOf: size)
        node.name = "acid"
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Acid
        node.physicsBody?.isDynamic = false
        let emitter = SKEmitterNode(fileNamed: "Acid")!
        emitter.particlePositionRange = CGVector(dx: size.width, dy: size.height)
        node.addChild(emitter)
        //TO DO
        // ADD colision and testcontact bit masks
        
        return node
    }
}
