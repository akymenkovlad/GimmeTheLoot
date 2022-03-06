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
        let node = BoxNode(texture: SKTexture(imageNamed: "box"), color: .cyan, size: size)
        node.name = "box"
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Box
        node.physicsBody?.density = 100
        return node
    }
}
