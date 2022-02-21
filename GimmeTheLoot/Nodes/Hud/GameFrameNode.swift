//
//  GameFrame.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import Foundation
import SpriteKit

public class GameFrameNode: SKShapeNode {
    
    
    public static func newInstance(with size: CGSize) -> GameFrameNode {
        let rectSize = CGSize(width: size.width - 20, height: size.width * 1.5 - 30)
        let  node = GameFrameNode(rectOf: rectSize)
        node.strokeColor = .red
        node.lineWidth = 2
        var bodies: [SKPhysicsBody] = []
        bodies.append(SKPhysicsBody(rectangleOf: CGSize(width: 5,
                                                        height: node.frame.height),
                                    center: CGPoint(x: node.frame.minX + 2.5,
                                                    y: 0)))
        bodies.append(SKPhysicsBody(rectangleOf: CGSize(width: 5,
                                                        height: node.frame.height),
                                    center: CGPoint(x: node.frame.maxX - 2.5,
                                                    y: 0)))
        bodies.append(SKPhysicsBody(rectangleOf: CGSize(width: node.frame.width,
                                                        height: 5),
                                    center: CGPoint(x: 0,
                                                    y: node.frame.maxY - 2.5)))
        bodies.append(SKPhysicsBody(rectangleOf: CGSize(width: node.frame.width,
                                                        height: 5),
                                    center: CGPoint(x: 0,
                                                    y: node.frame.minY + 2.5)))
        node.physicsBody = SKPhysicsBody(bodies: bodies)

        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsCategory.GameFrame
        return node
    }
}
