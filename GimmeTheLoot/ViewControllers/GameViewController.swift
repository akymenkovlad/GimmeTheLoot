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
    
    var level:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneNode = LevelScene(size: view.frame.size, level: level)
        sceneNode.scaleMode = .aspectFill
        sceneNode.transitionDelegate = self as TransitionDelegate
        
        print("aded delegate")
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
        if let view = self.view as! SKView? {
            view.presentScene(nil)
            print("removed")
        }
        self.dismiss(animated: true, completion: nil)
    }

}
