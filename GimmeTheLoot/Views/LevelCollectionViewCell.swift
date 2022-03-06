//
//  LevelCollectionViewCell.swift
//  GimmeTheLoot
//
//  Created by Valados on 13.02.2022.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    
    //@IBOutlet weak var levelLabel: UILabel!
    static let identifier = "LevelCollectionViewCell"
    
    var levelLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with level: Int) {
        levelLabel.text = "Level \(level)"
        levelLabel.font = UIFont(name: "Krungthep", size: 25)
        levelLabel.textAlignment = .center
        levelLabel.textColor = .yellow
        addSubview(levelLabel)
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        levelLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let defaults = UserDefaults.standard
        let userLevel = defaults.integer(forKey: "userLevel")
        switch userLevel >= level {
        case true:
            backgroundColor = .purple
        case false:
            backgroundColor = .gray
        }
        shadowDecorate()
        
    }
}
extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
