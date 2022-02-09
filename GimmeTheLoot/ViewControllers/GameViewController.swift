//
//  GameViewController.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneNode = LevelScene(size: view.frame.size)
        sceneNode.scaleMode = .aspectFill
        sceneNode.transitionDelegate = self as TransitionDelegate
        
        if let view = self.view as! SKView? {
            view.presentScene(sceneNode)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
extension GameViewController: TransitionDelegate {
    func returnToLevelsViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func return() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "CharacterSkinCollectionViewController") as! CharacterSkinCollectionViewController
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .fullScreen
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated: true, completion: nil)
//    }
}
