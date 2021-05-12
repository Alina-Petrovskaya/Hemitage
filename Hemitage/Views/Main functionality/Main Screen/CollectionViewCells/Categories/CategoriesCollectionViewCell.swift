//
//  CategoriesCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

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
    
    func updateContent<T> (with data: T) {
        guard let safeData = data as? MainScreenModelWrapper else { return }
        
        switch safeData {
        case .map(_):
            break
            
        case .category(let data):
            categoryName.text = data.name
            
            if data.imageName != "",  let image = UIImage(named: "\(data.imageName)")  {
                categoryImage.image = image
            }
            
        case .blog(_):
            break
        }
    }
    
}
