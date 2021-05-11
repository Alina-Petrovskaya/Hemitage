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
        let cornertRadius: CGFloat = 16.0
        
        contentView.layer.cornerRadius   = cornertRadius
        categoryImage.layer.cornerRadius = cornertRadius
        categoryName.layer.cornerRadius  = cornertRadius
        categoryName.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        categoryName.layer.masksToBounds = true
    }
}
