//
//  AcidNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

public class AcidNode: SKShapeNode {
    
    public static func newInstance(with size: CGSize, particleRange: CGSize) -> AcidNode {
        let size = CGSize(width: size.width ,height: size.height)
        let node = AcidNode(rectOf: size)
        node.zPosition = 10
        node.name = "acid"
        node.strokeColor = .clear
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Acid
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Boulder | PhysicsCategory.Player
        node.physicsBody?.isDynamic = false
        let emitter = SKEmitterNode(fileNamed: "Acid")!
        emitter.particlePositionRange = CGVector(dx: particleRange.width, dy: particleRange.height)
        node.addChild(emitter)
        emitter.position.y += particleRange.height * 0.8
        
        return node
    }
}
