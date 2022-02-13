//
//  LoseScene.swift
//  GimmeTheLoot
//
//  Created by Vlad Akymenko on 11.02.2022.
//

import SpriteKit

class GameOverScene: SKScene {
    
    weak var transitionDelegate: TransitionDelegate?
    
    private lazy var retryButton: SKSpriteNode! = SKSpriteNode(texture: retryButtonTexture, size: CGSize(width: 250, height: 100))
    private var menuButton: SKSpriteNode!
    private lazy var nextLevelButton: SKSpriteNode! = SKSpriteNode(texture: nextLevelButtonTexture, size: CGSize(width: 250, height: 100))
    
    private lazy var retryButtonTexture = SKTexture(imageNamed: "restart_button")
    private var menuButtonTexture = SKTexture(imageNamed: "menu_button")
    private lazy var nextLevelButtonTexture = SKTexture(imageNamed: "next_level_button")
    
    private var level: Int!
    private let defaults = UserDefaults.standard
    
    init(size: CGSize, won: Bool, level: Int) {
        super.init(size: size)
        
        backgroundColor = SKColor.white
        
        let message = won ? "You Won!" : "You Lose :["
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        
        menuButton = SKSpriteNode(texture: menuButtonTexture, size: CGSize(width: 250, height: 100))
        menuButton.position = CGPoint(x: size.width / 2, y: label.position.y - 100)
        addChild(menuButton)
        
        switch won {
        case true:
            if level >= defaults.integer(forKey: "userLevel") {
                defaults.set(level + 1, forKey: "userLevel")
            }
            if level < defaults.integer(forKey: "maxLevel") {
                nextLevelButton.position = CGPoint(x: size.width / 2, y: menuButton.position.y - 150)
                addChild(nextLevelButton)
            }
        case false:
            retryButton.position = CGPoint(x: size.width / 2, y: menuButton.position.y - 150)
            addChild(retryButton)
        }
        
        self.level = level
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: self) else { return }
        if menuButton.contains(touch) {
            handleMenuButtonClick()
        } else if retryButton.contains(touch) {
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let scene = LevelScene(size: size, level: level)
            scene.transitionDelegate = self.transitionDelegate
            self.view?.presentScene(scene, transition:reveal)
        } else if nextLevelButton.contains(touch) {
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let scene = LevelScene(size: size, level: level + 1)
            scene.transitionDelegate = self.transitionDelegate
            self.view?.presentScene(scene, transition:reveal)
        }
    }
    
    func handleMenuButtonClick() {
        print("return to LevelsViewController")
        guard let delegate = self.transitionDelegate else { return }
        guard let gestures = view?.gestureRecognizers else { return }
        for gesture in gestures {
            if let recognizerSwipe = gesture as? UISwipeGestureRecognizer {
                view!.removeGestureRecognizer(recognizerSwipe)
            }
            if let recognizerTap = gesture as? UITapGestureRecognizer {
                view!.removeGestureRecognizer(recognizerTap)
            }
        }
        delegate.returnToLevelsViewController()
    }
    
    deinit{
        print("GameOverScene deinited")
    }
}
