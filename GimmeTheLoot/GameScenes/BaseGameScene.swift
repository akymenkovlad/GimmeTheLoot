//
//  GameScene.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import SpriteKit
import GameplayKit


protocol TransitionDelegate: SKSceneDelegate {
    func returnToLevelsViewController()
}

class BaseGameScene: SKScene {
    
    var hud: HudNode!
    var gameFrame: GameFrameNode!
    
    var player: PlayerNode!
    var pins: [PinNode]! = []
    var touchedPin: PinNode!
    var money: MoneyNode!
    var acid: AcidNode!
    
    weak var transitionDelegate: TransitionDelegate?
    
    override func sceneDidLoad() {
    }
    
    override func didMove(to view: SKView) {
        hud = HudNode()
        hud.setup(size: size)
        hud.restartButtonAction = {
            print("restart level")
            for child in self.children {
                if child.name == "player" || child.name == "pin" || child.name == "prize" {
                    child.removeFromParent()
                }
            }
            self.configureLevelObjects()
        }
        hud.menuButtonAction = {
            print("return to LevelsViewController")
            guard let delegate = self.transitionDelegate else { return }
            guard view.gestureRecognizers != nil else { return }
            for gesture in view.gestureRecognizers! {
                if let recognizerSwipe = gesture as? UISwipeGestureRecognizer {
                    view.removeGestureRecognizer(recognizerSwipe)
                    print("gesture removed")
                }
            }
            self.hud.restartButtonAction = nil
            self.hud.menuButtonAction = nil
            delegate.returnToLevelsViewController()
        }
        addChild(hud)
        
        gameFrame = GameFrameNode.newInstance(with: size)
        gameFrame.position = CGPoint(x: size.width / 2,
                                     y: size.height / 2 - 50 )
        addChild(gameFrame)
        
        configureLevelObjects()
        setupSwipes()
    }
    
    public func configureLevelObjects() {
        player = PlayerNode.newInstance()
        player.position = CGPoint(x: size.width / 2,
                                  y: size.height / 2)
        addChild(player)
        
        pins = []
        pins.append(PinNode.newInstance(with: CGSize(width: gameFrame.frame.width * 0.6,
                                                     height: 20),
                                        direction: .left,
                                        in: CGPoint(x: size.width / 2,
                                                    y: size.height / 2)))
        for pin in pins {
            pin.position = CGPoint(x: size.width / 2,
                                   y: size.height / 2)
            pin.setAngle()
            addChild(pin)
        }
        money = MoneyNode.newInstance()
        money.position =  CGPoint(x: size.width / 2,
                                  y: size.height / 2 + 100)
        addChild(money)
        
        acid = AcidNode.newInstance()
        acid.position =  CGPoint(x: size.width / 2,
                                 y: size.height / 2 + 200)
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
    
    func setupSwipes() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        rightSwipe.direction = .right
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        upSwipe.direction = .up
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        leftSwipe.direction = .down
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        downSwipe.direction = .left
        
        [rightSwipe, upSwipe, leftSwipe, downSwipe].forEach { view?.addGestureRecognizer($0)}
        
        view?.addGestureRecognizer(rightSwipe)
    }
    
    @objc func didSwipe(sender: UISwipeGestureRecognizer) {
        guard let touchedPin = touchedPin, !touchedPin.wasMoved else { return }
        
        let pinDirection = touchedPin.direction
        var vector: CGVector!
        switch (pinDirection,sender.direction) {
        case (.left,.right):
            vector = CGVector(dx: touchedPin.movePinByShift(), dy: 0.0)
        case (.right,.left):
            vector = CGVector(dx: -touchedPin.movePinByShift(), dy: 0.0)
        case (.up,.down):
            vector = CGVector(dx: 0.0, dy: -touchedPin.movePinByShift())
        case (.down,.up):
            vector = CGVector(dx: 0.0, dy: touchedPin.movePinByShift())
        default:
            break
        }
        guard let vector = vector else { return }
        var actions = [SKAction]()
        actions.append(.move(by: vector, duration: 0.3))
        actions.append(.wait(forDuration: 0.5))
        actions.append(.run {
            self.touchedPin.removeFromParent()
            self.touchedPin = nil
        })
        self.touchedPin.run(.sequence(actions))
    }
}
extension BaseGameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact")
    }
}

