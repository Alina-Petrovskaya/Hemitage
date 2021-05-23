//
//  CategoriesCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit
import SDWebImage

class CategoriesCollectionViewCell: UICollectionViewCell, ConfiguringCell {
   
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
    
    
    func updateContent<T>(with viewModel: T) {
        guard let safeViewModel: MainScreenCollectionViewCellModelViewProtocol = viewModel as? CategoriesCollectionViewCellModelView
        else { return }
        
        let data: (imageURL: URL?, title: String) = safeViewModel.getData()
    
        categoryName.text = data.title
        
        if let safeURL = data.imageURL {
            categoryImage.sd_setImage(with: safeURL)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryImage.image = nil
        categoryName.text = ""
    }
    
}
