//
//  Platform.swift
//  GimmeTheLoot
//
//  Created by Valados on 18.02.2022.
//

import SpriteKit

public class PlatformNode: SKSpriteNode {
    
    public static func newInstance(with size: CGSize) -> PlatformNode {
        let node = PlatformNode(texture: nil,
                                color: .yellow,
                              size: CGSize(width: size.width,
                                           height: size.height))
        node.name = "platform"
        node.zPosition = 100
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.restitution = 0
        node.physicsBody?.categoryBitMask = PhysicsCategory.Platform
        node.physicsBody?.collisionBitMask = PhysicsCategory.Enemy | PhysicsCategory.Player | PhysicsCategory.Boulder
        
        return node
    }
    
    public func movePlatform(by distance: CGFloat, in direction: Directions) {
        let startPosition = self.position
        var vector: CGVector
        switch direction {
        case .left:
            vector = CGVector(dx: -distance, dy: 0)
        case .right:
            vector = CGVector(dx: distance, dy: 0)
        case .up:
            vector = CGVector(dx: 0, dy: distance)
        case .down:
            vector = CGVector(dx: 0, dy: -distance)
        }
        var actions = [SKAction]()
        actions.append(.wait(forDuration: 2.0))
        actions.append(.move(by: vector, duration: 2.0))
        actions.append(.wait(forDuration: 2.0))
        actions.append(.move(to: startPosition, duration: 2.0))
        self.run(.repeatForever(.sequence(actions)))
    }
    
}
