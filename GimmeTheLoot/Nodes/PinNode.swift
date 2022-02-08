//
//  PinNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit

public class PinNode: SKSpriteNode {
    
    public static func newInstance(with size: CGSize) -> PinNode {
        let node = PinNode(texture: nil,
                           color: .yellow,
                           size: CGSize(width: size.width,
                                        height: size.height))
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsCategory.Player
        return node
    }
}
