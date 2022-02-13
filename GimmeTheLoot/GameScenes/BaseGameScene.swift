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
    
    var levelModel: LevelModel! = LevelModel()
    var currentLevel: Int!
    
    let defaults = UserDefaults.standard
    
    var touchedPin: PinNode!
    var touchedNode: PlayerNode!
    
    weak var transitionDelegate: TransitionDelegate?
    
    override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
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
                }
                if let recognizerTap = gesture as? UITapGestureRecognizer {
                    view.removeGestureRecognizer(recognizerTap)
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
        setupTaps()
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
    }
    
    func setupTaps() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        tap.numberOfTapsRequired = 1
        view?.addGestureRecognizer(tap)
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
        actions.append(.run { [weak self] in
            guard let self = self else { return }
            self.touchedPin.removeFromParent()
            self.touchedPin = nil
        })
        self.touchedPin.run(.sequence(actions))
    }
    @objc func didTap(sender: UITapGestureRecognizer) {
        guard let touchedNode = self.touchedNode else { return }
        print("tapped")
        touchedNode.startMovement()
        self.touchedNode = nil
    }
    deinit{
        print("GameScene deinited")
    }
}
extension BaseGameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player || contact.bodyB.categoryBitMask == PhysicsCategory.Player {
            handlePlayerContact(contact: contact )
        }
        if (contact.bodyA.categoryBitMask == PhysicsCategory.Prize && contact.bodyB.categoryBitMask == PhysicsCategory.Player) || (contact.bodyB.categoryBitMask == PhysicsCategory.Prize && contact.bodyA.categoryBitMask == PhysicsCategory.Player) {
            levelModel.player.removeAllActions()
            levelModel.player.physicsBody = nil
            self.hud.restartButtonAction = nil
            self.hud.menuButtonAction = nil
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: true, level: currentLevel)
            gameOverScene.transitionDelegate = transitionDelegate
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
    }
    
    func handlePlayerContact(contact: SKPhysicsContact) {
        var playerBody: SKPhysicsBody
        var otherBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player {
            playerBody = contact.bodyA
            otherBody = contact.bodyB
        } else {
            playerBody = contact.bodyB
            otherBody = contact.bodyA
        }
        
        switch otherBody.categoryBitMask {
        case PhysicsCategory.GameFrame, PhysicsCategory.Pin:
            levelModel.player.changeDirection()
        default:
            break
        }
    }

}

