//
//  CategoriesCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    private func updateUI() {
        contentView.layer.cornerRadius = 16
        categoryImage.clipsToBounds    = true
        categoryImage.frame = content.frame
        categoryName.clipsToBounds     = true
    }
}
