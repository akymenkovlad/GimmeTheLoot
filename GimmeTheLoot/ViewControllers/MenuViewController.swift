//
//  MenuViewController.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    let soundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 80, height: 80)
        button.setImage(UIImage(named:"sound_on"), for: .normal)
        button.addTarget(self, action: #selector(onSoundButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        defaults.register(defaults: ["userLevel": 1])
        SoundManager.sharedInstance.startPlaying()
        if SoundManager.sharedInstance.isMuted {
            soundButton.setImage(UIImage(named: "sound_off"), for: .normal)
        } else {
            soundButton.setImage(UIImage(named: "sound_on"), for: .normal)
        }
        view.addSubview(soundButton)
        soundButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 100).isActive = true
        soundButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    @IBAction func toggleSoundButton(_ sender: Any) {
       
       
    }
    @objc func onSoundButtonPressed(_ sender: Any) {
        if SoundManager.sharedInstance.toggleMute() {
            soundButton.setImage(UIImage(named: "sound_off"), for: .normal)
        } else {
            soundButton.setImage(UIImage(named: "sound_on"), for: .normal)
        }
    }
    @IBAction func goToLevelScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let levelVC = storyboard.instantiateViewController(withIdentifier: "LevelsViewController") as! LevelsCollectionViewController
        let navBar = UINavigationController(rootViewController: levelVC)
        navBar.modalTransitionStyle = .coverVertical
        navBar.modalPresentationStyle = .fullScreen
        self.present(navBar, animated: true, completion: nil)
    }
}
