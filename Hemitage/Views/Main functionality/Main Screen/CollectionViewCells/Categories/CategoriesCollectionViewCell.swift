//
//  CategoriesCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateUI() {
        contentView.layer.cornerRadius = 16
        categoryImage.clipsToBounds    = true
        categoryName.clipsToBounds     = true
    }
}
