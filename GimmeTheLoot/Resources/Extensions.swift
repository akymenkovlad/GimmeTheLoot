//
//  Extensions.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit

extension SKNode {
    
    static func obstacleByDuplicatingPath(_ path: UIBezierPath, clockwise: Bool, with color: SKColor) -> SKNode {
        let container = SKNode()
        
        var rotationFactor = Double.pi/2
        if !clockwise {
            rotationFactor *= -1
        }
        for i in 0...3 {
            let section = SKShapeNode(path: path.cgPath)
            section.fillColor = color
            section.strokeColor = color
            section.zRotation = rotationFactor * CGFloat(i);
            let sectionBody = SKPhysicsBody(polygonFrom: path.cgPath)
        //    sectionBody.categoryBitMask = PhysicsCategory.Obstacle
            sectionBody.collisionBitMask = 0
          //  sectionBody.contactTestBitMask = PhysicsCategory.Player
            sectionBody.affectedByGravity = false
            section.physicsBody = sectionBody
            container.addChild(section)
        }
        return container
    }
    public static func createNewCircleInstance(radius: CGFloat, width: CGFloat,with color: SKColor) -> SKNode {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: -(radius+width)))
        path.addLine(to: CGPoint(x: 0, y: -radius))
        path.addArc(withCenter: CGPoint.zero,
                    radius: radius,
                    startAngle: CGFloat(3.0 * .pi/2),
                    endAngle: CGFloat(0),
                    clockwise: true)
        path.addLine(to: CGPoint(x: radius+width, y: 0))
        path.addArc(withCenter: CGPoint.zero,
                    radius: radius+width,
                    startAngle: CGFloat(0.0),
                    endAngle: CGFloat(3.0 * .pi/2),
                    clockwise: false)
        let obstacle = SKNode.obstacleByDuplicatingPath(path, clockwise: true, with: color)
        let rotateAction = SKAction.rotate(byAngle: 2.0 * .pi, duration: 4.0)
        obstacle.run(SKAction.repeatForever(rotateAction))
        return obstacle
    }
    
    public static func createNewSquareInstance(height: CGFloat, width: CGFloat,with color: SKColor) -> SKNode {
        let path = UIBezierPath(roundedRect: CGRect(x: -height/2, y: -height/2,
                                                    width: width, height: height),
                                cornerRadius: 20)
        let obstacle = SKNode.obstacleByDuplicatingPath(path, clockwise: false, with: color)
        return obstacle
    }
    
    public static func createNewCrossesInstance(height: CGFloat, width: CGFloat,with color: SKColor) -> SKNode {
        let path = UIBezierPath(roundedRect: CGRect(x: -width/2, y: -width/2,
                                                    width: width, height: height),
                                cornerRadius: 20)
        let obstacle = SKNode.obstacleByDuplicatingPath(path, clockwise: false, with: color)
        let rotateLeft = SKAction.rotate(byAngle: -2.0 * .pi, duration: 4.0)
        obstacle.run(.repeatForever(rotateLeft))
        return obstacle
    }
    public static func createNewStarInstance(radius: CGFloat, width: CGFloat,with color: SKColor) -> SKNode {
        let path = UIBezierPath()
        let degreesToRadians = CGFloat.pi / 180
        path.move(to: CGPoint(x: 0, y: -radius-width))
        path.addArc(withCenter: CGPoint(x: radius+width, y: -radius-width),
                    radius: radius,
                    startAngle: degreesToRadians * 180,
                    endAngle: degreesToRadians * 90,
                    clockwise: false)
        path.addLine(to: CGPoint(x: radius+width, y: width))
        path.addArc(withCenter: CGPoint(x: radius+width, y: -radius-width),
                    radius: radius+width,
                    startAngle: degreesToRadians * 90,
                    endAngle: degreesToRadians * 180,
                    clockwise: true)
        let obstacle = SKNode.obstacleByDuplicatingPath(path, clockwise: true, with: color)
        let rotateAction = SKAction.rotate(byAngle: 2.0 * .pi, duration: 5.0)
        obstacle.run(SKAction.repeatForever(rotateAction))
        return obstacle
    }
}
