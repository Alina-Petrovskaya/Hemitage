//
//  SubGroupCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import UIKit

class SubGroupCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var title: UILabel!
    
    
    override var isSelected: Bool {
            didSet {
                self.contentView.backgroundColor = isSelected ? UIColor(named: Constants.Colors.mainColor) : .white
                self.title.textColor = isSelected ? .white : UIColor(named: Constants.Colors.mainColor)
            }
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
