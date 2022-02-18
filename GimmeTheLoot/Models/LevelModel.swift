//
//   .swift
//  GimmeTheLoot
//
//  Created by Vlad Akymenko on 11.02.2022.
//

import Foundation
import SpriteKit

class LevelModel   {
    var player: PlayerNode!
    var pins: [PinNode]! = []
    var prize: PrizeNode!
    var acid: AcidNode!
    var enemy: EnemyNode!
    var ground: [GroundNode]! = []
    var box: BoxNode!
    var boulder: BoulderNode!
    var platform: PlatformNode!
    
    public func configureScene(in level: Int, frame: CGRect ) {
        let playerSize = CGSize(width: frame.size.width * 0.1, height: frame.size.height * 0.1)
        let prizeSize = CGSize(width: frame.size.width * 0.2, height: frame.size.height * 0.08)
        let enemySize = CGSize(width: frame.size.width * 0.1, height: frame.size.height * 0.1)
        
        player = PlayerNode.newInstance(with: playerSize)
        prize = PrizeNode.newInstance(with: prizeSize)
        
        var groundsSize: [CGSize]! = []
        var groundsPositions: [CGPoint]! = []
        var pinsDirections: [Directions]! = []
        var pinsPositions: [CGPoint]! = []
        let pinSize = CGSize(width: frame.width * 0.4, height: 15)
        
        switch level {
            
        case 1:
            groundsSize = [CGSize(width: frame.width - 5, height: frame.height / 7)]
            groundsPositions = [CGPoint(x: frame.midX, y: frame.minY + frame.height / 14)]
            pinsPositions = [CGPoint(x: frame.midX,
                                     y:  groundsPositions[0].y + (groundsSize[0].height + pinSize.width) / 2)]
            pinsDirections = [.down]
            
            player.position = CGPoint(x: frame.minX + player.size.width,
                                      y:  groundsPositions[0].y + (groundsSize[0].height + player.size.height) / 2)
            prize.position =  CGPoint(x: frame.maxX - prize.size.width,
                                      y: groundsPositions[0].y + prize.size.height / 2)
        case 2:
            groundsSize = [
                CGSize(width: frame.width * 0.4, height: frame.height * 0.1),
                CGSize(width: frame.width * 0.3, height: frame.height * 0.1),
                CGSize(width: frame.width * 0.4, height: frame.height * 0.075),
                CGSize(width: frame.width * 0.3, height: frame.height * 0.075)
            ]
            groundsPositions = [
                CGPoint(x: frame.minX + frame.width * 0.2, y: frame.minY + frame.height * 0.05),
                CGPoint(x: frame.maxX - frame.width * 0.15, y: frame.minY + frame.height * 0.05),
                CGPoint(x: frame.minX + frame.width * 0.2, y: frame.midY + frame.height * 0.075),
                CGPoint(x: frame.maxX - frame.width * 0.15, y: frame.midY + frame.height * 0.075),
            ]
            pinsPositions = [CGPoint(x: groundsPositions[2].x + (groundsSize[2].width + pinSize.width) / 2,
                                     y:  groundsPositions[2].y - (groundsSize[0].height - pinSize.height) / 2)]
            pinsDirections = [.left]
            
            acid = AcidNode.newInstance(with: CGSize(width: frame.width * 0.3, height: frame.height * 0.01))
            acid.position = CGPoint(x: frame.minX + frame.width * 0.55, y: frame.minY + acid.frame.height / 2)
            
            box = BoxNode.newInstance(with: CGSize(width: frame.width * 0.25, height: frame.height * 0.09))
            box.position = CGPoint(x: acid.position.x,
                                   y: pinsPositions[0].y + (pinSize.width + box.size.height) / 2)
            
            player.position = CGPoint(x: frame.minX +  player.size.width,
                                      y:  groundsPositions[0].y + (groundsSize[0].height + player.size.height) / 2)
            prize.position =  CGPoint(x: frame.maxX - prize.size.width * 0.8,
                                      y: groundsPositions[0].y + (groundsSize[0].height + prize.size.height) / 2)
        case 3:
            groundsSize = [
                CGSize(width: frame.width, height: frame.height * 0.1),
                CGSize(width: frame.width * 0.75 , height: frame.height * 0.1)
            ]
            groundsPositions = [
                CGPoint(x: frame.midX, y: frame.minY + frame.height * 0.075),
                CGPoint(x: frame.minX + frame.width * 0.375, y: frame.minY + frame.height * 0.65)
            ]
            pinsPositions = [CGPoint(x: frame.midX,
                                     y:  groundsPositions[0].y + (groundsSize[0].height + pinSize.width) / 2),
                             CGPoint(x: frame.minX + pinSize.width / 2, y: frame.maxY - frame.height * 0.15 )
            ]
            pinsDirections = [.down, .left]
            
            platform = PlatformNode.newInstance(with: CGSize(width: frame.width * 0.2, height: frame.height * 0.025))
            platform.position = CGPoint(x: frame.maxX - frame.width * 0.15, y: frame.minX + frame.height * 0.2)
            platform.movePlatform(by: frame.height * 0.55, in: .up)
            
            player.position = CGPoint(x: frame.minX +  player.size.width,
                                      y:  groundsPositions[0].y + (groundsSize[0].height + player.size.height) / 2)
            prize.position =  CGPoint(x: frame.minX + prize.size.width ,
                                      y: frame.maxY - prize.size.height / 2)
        case 4:
            groundsSize = [
                CGSize(width: frame.width - 5, height: frame.height / 8),
                CGSize(width: frame.width * 0.8 - 5, height: 40),
                CGSize(width: frame.width * 0.4 - 5, height: 15)
            ]
            groundsPositions = [
                CGPoint(x: frame.midX, y: frame.minY + frame.height / 14),
                CGPoint(x: frame.minX + groundsSize[1].width / 2, y: frame.maxY - 200),
                CGPoint(x: frame.maxX - groundsSize[2].width / 2, y: frame.maxY - 300)
            ]
            pinsPositions = [CGPoint(x: frame.maxX - pinSize.width / 2,
                                     y:  groundsPositions[1].y - (groundsSize[1].height - pinSize.height) / 2)]
            pinsDirections = [.right]
            
            enemy = EnemyNode.newInstance(with: enemySize)
            
            
            player.position = CGPoint(x: frame.minX + player.size.width,
                                      y:  groundsPositions[1].y + (groundsSize[1].height + player.size.height) / 2)
            prize.position =  CGPoint(x: frame.minX + prize.size.width,
                                      y: groundsPositions[0].y + prize.size.height / 2)
            enemy.position = CGPoint(x: prize.position.x + (prize.size.width + enemy.size.width + 20) / 2, y: groundsPositions[0].y + enemy.size.height / 2)
        case 5:
            groundsSize = [
                //0
                CGSize(width: frame.width * 0.25, height: frame.height * 0.135),
                //1
                CGSize(width: frame.width * 0.25, height: frame.height * 0.2),
                //2
                CGSize(width: frame.width * 0.25, height: frame.height * 0.025),
                //3
                CGSize(width: frame.width * 0.25, height: frame.height * 0.03),
                //4
                CGSize(width: player.size.width + pinSize.height + 5, height: frame.height * 0.50),
                //5
                CGSize(width: frame.width * 0.5, height: frame.height * 0.2),
                //6
                CGSize(width: frame.width * 0.50, height: frame.height * 0.265),
                //7
                CGSize(width: frame.width * 0.01, height: frame.height * 0.38),
                //8
                CGSize(width: frame.width * 0.15, height: frame.height * 0.02)
            ]
            groundsPositions = [
                //0
                CGPoint(x: frame.maxX - frame.width * 0.125, y: frame.minY + frame.height * 0.3325),
                //1
                CGPoint(x: frame.maxX - frame.width * 0.125, y: frame.maxY - frame.height * 0.1),
                //2
                CGPoint(x: frame.maxX - frame.width * 0.125, y: frame.maxY - frame.height * 0.35),
                //3
                CGPoint(x: frame.maxX - frame.width * 0.125, y: frame.maxY - frame.height * 0.35 + 5),
                //4
                CGPoint(x: frame.minX + (player.size.width + pinSize.height) / 2, y: frame.minY + frame.height * 0.25),
                //5
                CGPoint(x: frame.minX + frame.width * 0.25, y: frame.maxY - frame.height * 0.1),
                //6
                CGPoint(x: frame.maxX - frame.width * 0.250, y: frame.minY + frame.height * 0.1325),
                //7
                CGPoint(x: frame.maxX - frame.width * 0.505, y: frame.minY + frame.height * 0.19),
                //8
                CGPoint(x: frame.minX + frame.width * 0.37, y: frame.minY + frame.height * 0.38)
            ]
            pinsPositions = [
                CGPoint(x: frame.maxX - frame.width * 0.25 + pinSize.height / 2,
                        y:  frame.maxY - frame.height * 0.35 + 5 + pinSize.width / 2),
                CGPoint(x: frame.minX + player.size.width + pinSize.height + 5 - pinSize.height / 2,
                        y:  frame.minY + frame.height * 0.50 + pinSize.width / 2),
                CGPoint(x: frame.width * 0.625,
                        y:  frame.maxY - frame.height * 0.2 + pinSize.height / 2)
            ]
            pinsDirections = [
                .down,
                .down,
                .right
            ]
            box = BoxNode.newInstance(with: CGSize(width: frame.height * 0.125, height: frame.height * 0.125))
            box.position = CGPoint(x: frame.width * 0.75,
                                   y: frame.maxY - box.size.height / 2)
            
            boulder = BoulderNode.newInstance(with: frame.height * 0.09)
            boulder.position = CGPoint(x: frame.maxX - frame.width * 0.125, y: frame.maxY - frame.height * 0.26 + 5)
            
            enemy = EnemyNode.newInstance(with: enemySize)
            enemy.position = CGPoint(x: frame.minX + frame.width * 0.35,
                                     y: frame.minY + frame.height * 0.45)
            
            acid = AcidNode.newInstance(with: CGSize(width: frame.width * 0.25, height: frame.height * 0.01))
            acid.position = CGPoint(x: frame.maxX - frame.width * 0.375, y: frame.minY + frame.height * 0.27)
            
            player.position = CGPoint(x: frame.minX + 5 + frame.size.width * 0.05,
                                      y:  frame.minY + frame.height * 0.55)
            prize.position =  CGPoint(x: frame.maxX - frame.size.width * 0.1,
                                      y: frame.minY + frame.height * 0.44)
        default:
            break
        }
        if !groundsSize.isEmpty {
            for i in 0..<groundsSize.count {
                ground.append(GroundNode.newInstance(with: groundsSize[i]))
                ground[i].position = CGPoint(x: groundsPositions[i].x, y: groundsPositions[i].y)
            }
        }
        if !pinsPositions.isEmpty {
            for i in 0..<pinsPositions.count {
                pins.append(PinNode.newInstance(with: pinSize, direction: pinsDirections[i]))
                pins[i].position = CGPoint(x: pinsPositions[i].x, y: pinsPositions[i].y)
                pins[i].setAngle()
            }
        }
        switch level {
        case 4:
            enemy.startMovement()
        case 5:
            ground[3].physicsBody?.node?.zRotation = 0.1
        default:
            break
        }
    }
}
