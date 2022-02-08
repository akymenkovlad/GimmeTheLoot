//
//  GameScene.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var hud: HudNode!
    private var gameFrame: GameFrameNode!
    private var player: PlayerNode!
    private var pins: [PinNode]!
    
    private var count = 0
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        hud = HudNode()
        hud.setup(size: size)
        hud.restartButtonAction = {
            print("restart")
        }
        hud.menuButtonAction = {
            print("menu")
        }
        addChild(hud)
        
        gameFrame = GameFrameNode.newInstance(with: size)
        gameFrame.position = CGPoint(x: size.width / 2,
                                     y: size.height / 2 - 50 )
        addChild(gameFrame)
        
        player = PlayerNode.newInstance()
        player.position = CGPoint(x: size.width / 2,
                                  y: size.height / 2)
        addChild(player)
        
        pins = []
        pins.append(PinNode.newInstance(with: CGSize(width: gameFrame.frame.width * 0.6,
                                                     height: 10)))
        for pin in pins {
            pin.position = CGPoint(x: size.width / 2,
                                   y: size.height / 2)
            addChild(pin)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let first = touches.first else { return }
        let location = first.location(in: self)
        hud.touchBeganAtPoint(point: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let pin = pins.first(where: { node in node.contains(touch.location(in: self))}) {
                pin.position.x = touch.location(in: self).x
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        self.lastUpdateTime = currentTime
    }
}
