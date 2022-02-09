//
//  MenuViewController.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
