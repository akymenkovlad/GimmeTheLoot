//
//  ChooseLevelViewController.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import UIKit

class LevelsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goToGameScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameVC = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        gameVC.modalTransitionStyle = .coverVertical
        gameVC.modalPresentationStyle = .fullScreen
        self.present(gameVC, animated: true, completion: nil)
    }

}
