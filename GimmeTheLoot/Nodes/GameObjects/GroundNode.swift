//
//  GroundNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

public class GroundNode: SKSpriteNode {
    
    public static func newInstance(with size: CGSize) -> GroundNode {
        let node = GroundNode(texture: SKTexture(imageNamed: "ground"),
                              color: .brown,
                              size: CGSize(width: size.width,
                                           height: size.height))
        node.name = "ground"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsCategory.Ground
        node.physicsBody?.collisionBitMask = PhysicsCategory.Prize | PhysicsCategory.Enemy | PhysicsCategory.Player 
        
        return node
    }
    public func setAngle(_ angle: CGFloat) {
        self.zRotation = angle
    }
}
