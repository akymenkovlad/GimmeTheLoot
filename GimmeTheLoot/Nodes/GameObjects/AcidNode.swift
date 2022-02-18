//
//  AcidNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

public class AcidNode: SKShapeNode {
    
    public static func newInstance(with size: CGSize) -> AcidNode {
        let size = CGSize(width: size.width ,height: size.height)
        let node = AcidNode(rectOf: size)
        node.name = "acid"
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Acid
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Boulder | PhysicsCategory.Player
        node.physicsBody?.isDynamic = false
        let emitter = SKEmitterNode(fileNamed: "Acid")!
        emitter.particlePositionRange = CGVector(dx: size.width, dy: size.height * 5)
        node.addChild(emitter)
        emitter.position.y += size.height * 5
        
        return node
    }
}
