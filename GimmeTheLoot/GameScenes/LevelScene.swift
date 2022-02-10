//
//  Level1Scene.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

class LevelScene: BaseGameScene {
    
    private var currentLevel: Int!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view) //
        print("moved")
        print(currentLevel)
        hud.restartButtonAction = {
            print("restart level")
            for child in self.children {
                if child.name == "player" || child.name == "pin" || child.name == "prize" {
                    child.removeFromParent()
                }
            }
            self.configureLevelObjects()
        }
        print(gameFrame.position)
        print(gameFrame.calculateAccumulatedFrame())
        configureLevelObjects()
    }
    
    public func configureLevelObjects() {
        let frameWidth = gameFrame.frame.midX - gameFrame.frame.minX
        let frameHeight = gameFrame.frame.midY - gameFrame.frame.minY
        player = PlayerNode.newInstance()
        player.position = CGPoint(x: -frameWidth + player.size.width / 2,
                                  y: -frameHeight + player.size.height / 2)
        addChild(player)
        
        pins = []
        pins.append(PinNode.newInstance(with: CGSize(width: gameFrame.frame.midX * 0.6,
                                                     height: 20),
                                        direction: .left))
        for pin in pins {
            pin.position = CGPoint(x: gameFrame.frame.minX,
                                   y: gameFrame.frame.minY)
            pin.setAngle()
            addChild(pin)
        }
        money = MoneyNode.newInstance()
        money.position =  CGPoint(x: pins[0].position.x,
                                  y: pins[0].position.y + 20)
        addChild(money)
        
        acid = AcidNode.newInstance()
        acid.position =  CGPoint(x: 0 ,
                                 y: -frameHeight - acid.frame.size.height / 2)
        addChild(acid)
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let first = touches.first else { return }
        let location = first.location(in: self)
        if let pin = pins.first(where: { node in node.contains(location) }) {
            touchedPin = pin
        } else {
            hud.touchBeganAtPoint(point: location)
        }
    }
}
