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
    
    public func configureScene(in level: Int, frame: CGRect ) {
        player = PlayerNode.newInstance()
        prize = PrizeNode.newInstance()
        
        var groundsSize: [CGSize]! = []
        var groundsPositions: [CGPoint]! = []
        var pinsDirections: [PinDirections]! = []
        var pinsPositions: [CGPoint]! = []
        let pinSize = CGSize(width: frame.width * 0.4, height: 20)
        
        switch level {
            
        case 1:
            groundsSize = [CGSize(width: frame.width - 5, height: frame.height / 7)]
            groundsPositions = [CGPoint(x: frame.midX, y: frame.minY + frame.height / 14)]
            pinsPositions = [CGPoint(x: frame.midX,
                                     y:  groundsPositions[0].y + (groundsSize[0].height + pinSize.width) / 2)]
            pinsDirections = [.down]
            
            player.position = CGPoint(x: frame.minX + 5 +  player.size.width / 2,
                                      y:  groundsPositions[0].y + (groundsSize[0].height + player.size.height) / 2)
            prize.position =  CGPoint(x: frame.maxX - prize.size.width / 2,
                                      y: groundsPositions[0].y + prize.size.height / 2)
        case 2:
            groundsSize = [
                CGSize(width: frame.width - 5, height: frame.height / 7),
                CGSize(width: frame.width * 0.7 - 5 , height: frame.height / 7)
            ]
            groundsPositions = [
                CGPoint(x: frame.midX, y: frame.minY + frame.height / 14),
                CGPoint(x: frame.maxX - groundsSize[1].width / 2, y: frame.midY + 150),            ]
            pinsPositions = [CGPoint(x: frame.midX,
                                     y:  groundsPositions[0].y + (groundsSize[0].height + pinSize.width) / 2),
                             CGPoint(x: frame.minX + pinSize.width / 2, y: groundsPositions[1].y - (groundsSize[1].height - pinSize.height) / 2 )
            ]
            pinsDirections = [.down, .left]
            
            player.position = CGPoint(x: frame.maxX -  player.size.width / 2,
                                      y:  groundsPositions[0].y + (groundsSize[0].height + player.size.height) / 2)
            prize.position =  CGPoint(x: frame.minX + 5 + prize.size.width / 2 ,
                                      y: pinsPositions[1].y + prize.size.height / 2)
        case 3:
            groundsSize = [
                CGSize(width: frame.width * 0.35, height: 100),
                CGSize(width: frame.width * 0.35, height: 100),
                CGSize(width: frame.width * 0.35, height: 100),
                CGSize(width: frame.width * 0.35, height: 100)
            ]
            groundsPositions = [
                CGPoint(x: frame.minX + groundsSize[0].width / 2, y: frame.minY + 50),
                CGPoint(x: frame.maxX - groundsSize[1].width / 2, y: frame.minY + 50),
                CGPoint(x: frame.minX + groundsSize[2].width / 2, y: frame.midY + 50),
                CGPoint(x: frame.maxX - groundsSize[3].width / 2, y: frame.midY + 50),
            ]
            pinsPositions = [CGPoint(x: groundsPositions[2].x + (groundsSize[2].width + pinSize.width) / 2,
                                     y:  groundsPositions[2].y - (groundsSize[0].height - pinSize.height) / 2)]
            pinsDirections = [.left]
            
            acid = AcidNode.newInstance(with: CGSize(width: frame.width * 0.3, height: 50))
            acid.position = CGPoint(x: frame.midX, y: frame.minY + acid.frame.height / 2 - 1)
            
            box = BoxNode.newInstance(with: CGSize(width: acid.frame.width * 0.9, height: 50))
            box.position = CGPoint(x: acid.position.x,
                                   y: pinsPositions[0].y + (pinSize.width + box.size.height) / 2)
            
            player.position = CGPoint(x: frame.minX +  player.size.width / 2,
                                      y:  groundsPositions[0].y + (groundsSize[0].height + player.size.height) / 2)
            prize.position =  CGPoint(x: frame.maxX - prize.size.width / 2,
                                      y: groundsPositions[0].y + (groundsSize[0].height + prize.size.height) / 2)
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
            
            enemy = EnemyNode.newInstance()
            
            
            player.position = CGPoint(x: frame.minX + 5 +  player.size.width / 2,
                                      y:  groundsPositions[1].y + (groundsSize[1].height + player.size.height) / 2)
            prize.position =  CGPoint(x: frame.minX + prize.size.width / 2,
                                      y: groundsPositions[0].y + prize.size.height / 2)
            enemy.position = CGPoint(x: prize.position.x + (prize.size.width + enemy.size.width + 20) / 2, y: groundsPositions[0].y + enemy.size.height / 2)
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
    }
}
