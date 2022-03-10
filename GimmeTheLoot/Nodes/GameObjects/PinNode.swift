//
//  PinNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit

public class PinNode: SKSpriteNode {
    
    private(set) var direction: Directions = .left
    private var shift: CGFloat {
        get {
            self.size.height * 0.8
        }
    }
    private(set) var wasMoved = false
    
    public static func newInstance(with size: CGSize, direction: Directions) -> PinNode {
        let node = PinNode(texture: SKTexture(imageNamed: "pin"),
                           color: .yellow,
                           size: CGSize(width: size.height,
                                        height: size.width))
        node.name = "pin"
        node.direction = direction
        node.zPosition = 50
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.height / 2, height: size.width))
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsCategory.Pin
        return node
    }
    
    public func setAngle() {
        var angle: CGFloat = 0.0
        switch direction {
        case .left:
            angle = -.pi / 2
        case .right:
            angle = .pi / 2
        case .up:
            angle = .pi
        case .down:
            angle = 0.0
        }
        self.zRotation = angle
    }
    public func movePinByShift() -> CGFloat{
        wasMoved = true
        return shift
    }
}
