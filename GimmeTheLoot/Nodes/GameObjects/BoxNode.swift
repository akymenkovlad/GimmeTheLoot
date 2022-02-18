//
//  BoxNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 15.02.2022.
//

import SpriteKit

public class BoxNode: SKSpriteNode {
    
    public static func newInstance(with size: CGSize) -> BoxNode {
        let size = CGSize(width: size.width ,height: size.height)
        let node = BoxNode(texture: nil, color: .cyan, size: size)
        node.name = "box"
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Box
        node.physicsBody?.density = 1000
        
        return node
    }
}
