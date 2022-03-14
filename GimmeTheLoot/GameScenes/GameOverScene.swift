//
//  LoseScene.swift
//  GimmeTheLoot
//
//  Created by Vlad Akymenko on 11.02.2022.
//

import SpriteKit

class GameOverScene: SKScene {
    
    weak var transitionDelegate: TransitionDelegate?
    
    private lazy var retryButton: SKSpriteNode! = SKSpriteNode(texture: retryButtonTexture, size: CGSize(width: 200, height: 80))
    private var menuButton: SKSpriteNode!
    private lazy var nextLevelButton: SKSpriteNode! = SKSpriteNode(texture: nextLevelButtonTexture, size: CGSize(width: 200, height: 80))
    
    private lazy var retryButtonTexture = SKTexture(imageNamed: "restart_button")
    private var menuButtonTexture = SKTexture(imageNamed: "menu_button")
    private lazy var nextLevelButtonTexture = SKTexture(imageNamed: "next_level_button")
    
    private lazy var loseButtonTexture = SKTexture(imageNamed: "lose_label")
    private lazy var winButtonTexture = SKTexture(imageNamed: "win_label")
    private var resultNode: SKSpriteNode!
    
    private var background: SKSpriteNode!
    
    private var level: Int!
    private let defaults = UserDefaults.standard
    private var won: Bool!
    
    init(size: CGSize, won: Bool, level: Int) {
        super.init(size: size)
        self.won = won
        background = SKSpriteNode(texture: SKTexture(imageNamed: "background_1"), size: size)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -100
        addChild(background)
        let texture = won ? winButtonTexture.size() : loseButtonTexture.size()
        resultNode = SKSpriteNode(texture: won ? winButtonTexture : loseButtonTexture,
                                  size: CGSize(width: texture.width / 2, height: texture.height / 2))
        resultNode.position = CGPoint(x: size.width/2, y: size.height * 0.8)
        addChild(resultNode)
        
        
        menuButton = SKSpriteNode(texture: menuButtonTexture, size: CGSize(width: 200, height: 80))
        menuButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(menuButton)
        
        switch won {
        case true:
            if level >= defaults.integer(forKey: "userLevel") && level < NumberOfLevels {
                defaults.set(level + 1, forKey: "userLevel")
            }
            if level < NumberOfLevels {
                nextLevelButton.position = CGPoint(x: size.width / 2, y: menuButton.position.y - 125)
                addChild(nextLevelButton)
            }
        case false:
            retryButton.position = CGPoint(x: size.width / 2, y: menuButton.position.y - 125)
            addChild(retryButton)
        }
        
        self.level = level
    }
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        if !SoundManager.sharedInstance.isMuted {
            run(.playSoundFileNamed(won ? "win.mp3" : "lose.mp3", waitForCompletion: true))
        }
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
