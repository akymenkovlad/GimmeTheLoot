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
                                     y: size.height / 2 - 25 )
        addChild(gameFrame)
        
        setupSwipes()
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
        print("swiped")
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

