//
//  LevelsCollectionViewController.swift
//  GimmeTheLoot
//
//  Created by Valados on 06.03.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class LevelsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Select level"
        self.navigationController?.navigationBar.barTintColor = .purple
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.yellow, NSAttributedString.Key.font: UIFont(name: "Krungthep", size: 25)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        setUpMenuButton()
        
        self.collectionView!.register(LevelCollectionViewCell.self, forCellWithReuseIdentifier: LevelCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func setUpMenuButton(){
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        menuBtn.setImage(UIImage(named:"quit_button"), for: .normal)
        menuBtn.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 35)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 35)
        currHeight?.isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    @objc func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: UICollectionViewDataSource & UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NumberOfLevels
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let skinCell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCollectionViewCell.identifier, for: indexPath) as! LevelCollectionViewCell
        skinCell.configure(with: indexPath.row + 1)
        return skinCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125 , height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftInset = 50.0
        let rightInset = leftInset
        return UIEdgeInsets(top: 50, left: leftInset, bottom: 0, right: rightInset)
    }
    
}
