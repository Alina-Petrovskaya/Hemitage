//
//  CategoriesCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var content: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    private func updateUI() {
        let cornetRadius: CGFloat = 16.0
        
        contentView.layer.cornerRadius   = cornetRadius
        categoryImage.layer.cornerRadius = cornetRadius
        categoryName.layer.cornerRadius  = cornetRadius
        categoryName.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        categoryName.layer.masksToBounds = true
    }
}
