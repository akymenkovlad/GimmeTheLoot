//
//  BoulderNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 15.02.2022.
//
import SpriteKit

public class BoulderNode: SKSpriteNode {
    
    public static func newInstance(with radius: CGFloat) -> BoulderNode {
        let node = BoulderNode(texture: nil, color: .cyan, size: CGSize(width: radius, height: radius))
        node.name = "boulder"
        node.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Boulder
        
        return node
    }
}
