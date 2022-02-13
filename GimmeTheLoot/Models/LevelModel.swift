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
    var ground: [GroundNode]! = []
    
    public func configureScene(in level: Int, frame: CGRect ) {
        player = PlayerNode.newInstance()
        prize = PrizeNode.newInstance()
        
        var groundsSize: [CGSize]!
        var groundsPositions: [CGPoint]!
        var pinsDirections: [PinDirections]!
        var pinsPositions: [CGPoint]!
        let pinSize = CGSize(width: frame.width * 0.6, height: 20)
    
        switch level {
            
        case 1:
            groundsSize = [CGSize(width: frame.width - 5, height: frame.height / 7)]
            groundsPositions = [CGPoint(x: frame.midX, y: frame.minY + frame.height / 14)]
            pinsPositions = [CGPoint(x: frame.midX,
                                     y:  groundsPositions[0].y + (groundsSize[0].height + pinSize.width) / 2)]
            pinsDirections = [.down]
          
            player.position = CGPoint(x: frame.minX +  player.size.width / 2,
                                      y:  groundsPositions[0].y + player.size.height / 2)
            prize.position =  CGPoint(x: frame.maxX - prize.size.width / 2,
                                      y: groundsPositions[0].y + prize.size.height / 2)
        case 2:
            groundsSize = [CGSize(width: frame.width - 5, height: frame.height / 7)]
            groundsPositions = [CGPoint(x: frame.midX, y: frame.minY + frame.height / 14)]
            pinsPositions = [CGPoint(x: frame.midX,
                                     y:  groundsPositions[0].y + (groundsSize[0].height + pinSize.width) / 2)]
            pinsDirections = [.down]
          
            prize.position = CGPoint(x: frame.minX +  prize.size.width / 2,
                                      y:  groundsPositions[0].y + prize.size.height / 2)
            player.position =  CGPoint(x: frame.maxX - player.size.width / 2,
                                      y: groundsPositions[0].y + player.size.height / 2)
        case 3:
            break
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
