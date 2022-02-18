//
//  Level1Scene.swift
//  GimmeTheLoot
//
//  Created by Valados on 09.02.2022.
//

import SpriteKit

class LevelScene: BaseGameScene {
    
    
    init(size: CGSize, level:Int) {
        super.init(size: size)
        currentLevel = level
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        levelModel.configureScene(in: currentLevel, frame: gameFrame.frame)
        configureLevelObjects()
        
        hud.setTextForLabel("Level \(currentLevel!)")
        hud.restartButtonAction = {
            print("restart level")
            for child in self.children {
                if child.name == "player" || child.name == "pin" || child.name == "prize" ||  child.name == "ground" || child.name == "enemy" || child.name == "box" || child.name == "boulder" {
                    child.removeFromParent()
                }
            }
            self.levelModel = LevelModel()
            self.levelModel.configureScene(in: self.currentLevel, frame: self.gameFrame.frame)
            self.configureLevelObjects()
        }
    }
    
    public func configureLevelObjects() {
        
        for ground in levelModel.ground {
            addChild(ground)
        }
        for pin in levelModel.pins {
            addChild(pin)
        }
        if levelModel.enemy != nil {
            addChild(levelModel.enemy)
        }
        if levelModel.acid != nil {
            addChild(levelModel.acid)
        }
        if levelModel.box != nil {
            addChild(levelModel.box)
        }
        if levelModel.boulder != nil {
            addChild(levelModel.boulder)
        }
        if levelModel.platform != nil {
            addChild(levelModel.platform)
        }
        addChild(levelModel.player)
        addChild(levelModel.prize)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let first = touches.first else { return }
        let location = first.location(in: self)
        if let pin = levelModel.pins.first(where: { node in node.contains(location) }) {
            touchedPin = pin
        }
        if levelModel.player.contains(location) {
            touchedNode = levelModel.player
        }
        hud.touchBeganAtPoint(point: location)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if levelModel.player.isMoving {
            levelModel.player.updatePosition()
        }
        guard let enemy = levelModel.enemy else { return }
        enemy.updatePosition()
    }
}
