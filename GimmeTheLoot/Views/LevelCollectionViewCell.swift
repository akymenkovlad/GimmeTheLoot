//
//  LevelCollectionViewCell.swift
//  GimmeTheLoot
//
//  Created by Valados on 13.02.2022.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var levelLabel: UILabel!
    static let identifier = "LevelCollectionViewCell"

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with level: Int) {
        levelLabel.text = "Level \(level)"
        levelLabel.font = UIFont(name: "Chalkduster", size: 25)
        levelLabel.textAlignment = .center
        levelLabel.textColor = .white
        
        let defaults = UserDefaults.standard
        let userLevel = defaults.integer(forKey: "userLevel")
        switch userLevel >= level {
        case true:
            backgroundColor = .black
        case false:
            backgroundColor = .gray
        }
        
    }
}
