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
        let rectSize = CGSize(width: size.width - 50, height: size.height - 150)
        let  node = GameFrameNode(rectOf: rectSize)
        node.strokeColor = .red
        node.lineWidth = 5
        var bodies: [SKPhysicsBody] = []
        bodies.append(SKPhysicsBody(rectangleOf: CGSize(width: 1,
                                                        height: node.frame.height),
                                    center: CGPoint(x: node.frame.minX,
                                                    y: 0)))
        bodies.append(SKPhysicsBody(rectangleOf: CGSize(width: 1,
                                                        height: node.frame.height),
                                    center: CGPoint(x: node.frame.maxX,
                                                    y: 0)))
        bodies.append(SKPhysicsBody(rectangleOf: CGSize(width: node.frame.width,
                                                        height: 1),
                                    center: CGPoint(x: 0,
                                                    y: node.frame.maxY)))
        bodies.append(SKPhysicsBody(rectangleOf: CGSize(width: node.frame.width,
                                                        height: 1),
                                    center: CGPoint(x: 0,
                                                    y: node.frame.minY)))
        node.physicsBody = SKPhysicsBody(bodies: bodies)

        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsCategory.GameFrame
        return node
    }
}
