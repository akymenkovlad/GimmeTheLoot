//
//  PinNode.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit

public class PinNode: SKSpriteNode {
    
    private(set) var direction:PinDirections = .left
    private var shift: CGFloat {
        get {
            self.size.width * 0.8
        }
    }
    private(set) var wasMoved = false
    
    public static func newInstance(with size: CGSize, direction: PinDirections) -> PinNode {
        let node = PinNode(texture: SKTexture(imageNamed: "pin"),
                           color: .yellow,
                           size: CGSize(width: size.width,
                                        height: size.height))
        node.name = "pin"
        node.direction = direction
        
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsCategory.Pin
        //TO DO
        // ADD colision and testcontact bit masks
        return node
    }
    
    public func setAngle() {
        var angle: CGFloat = 0.0
        switch direction {
        case .left:
            angle = 0.0
        case .right:
            angle = .pi
        case .up:
            angle = -.pi / 2
        case .down:
            angle = .pi / 2
        }
        self.zRotation = angle
    }
    public func movePinByShift() -> CGFloat{
        wasMoved = true
        return shift
    }
}
