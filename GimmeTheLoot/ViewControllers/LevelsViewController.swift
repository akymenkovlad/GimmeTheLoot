//
//  ChooseLevelViewController.swift
//  GimmeTheLoot
//
//  Created by Valados on 08.02.2022.
//

import UIKit

class LevelsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var levelCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelCollectionView.dataSource = self
        levelCollectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        levelCollectionView.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension LevelsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NumberOfLevels
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let skinCell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCollectionViewCell.identifier, for: indexPath) as? LevelCollectionViewCell {
            skinCell.configure(with: indexPath.row + 1)
            cell = skinCell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userLevel = defaults.integer(forKey: "userLevel")
        if userLevel >= indexPath.row + 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let gameVC = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            gameVC.modalTransitionStyle = .coverVertical
            gameVC.modalPresentationStyle = .fullScreen
            gameVC.level = indexPath.row + 1
            self.present(gameVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125 , height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let leftInset = 30.0
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
}
