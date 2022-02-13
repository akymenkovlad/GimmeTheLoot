//
//  MenuViewController.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var soundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        defaults.register(defaults: ["maxLevel": 3])
        defaults.register(defaults: ["userLevel": 1])
        SoundManager.sharedInstance.startPlaying()
        if SoundManager.sharedInstance.isMuted {
            soundButton.setTitle("Sound Off", for: .normal)
        } else {
            soundButton.setTitle("Sound On", for: .normal)
        }
    }

    @IBAction func toggleSoundButton(_ sender: Any) {
        
        if SoundManager.sharedInstance.toggleMute() {
            soundButton.setTitle("Sound Off", for: .normal)
        } else {
            soundButton.setTitle("Sound On", for: .normal)
        }
        
    }
    @IBAction func goToLevelScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let levelVC = storyboard.instantiateViewController(withIdentifier: "LevelsViewController") as! LevelsViewController
        let navBar = UINavigationController(rootViewController: levelVC)
        navBar.modalTransitionStyle = .coverVertical
        navBar.modalPresentationStyle = .fullScreen
        self.present(navBar, animated: true, completion: nil)
    }
}
