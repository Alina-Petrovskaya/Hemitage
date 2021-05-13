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
    
    var viewModel: CategoriesCollectionViewCellModelViewProtocol = CategoriesCollectionViewCellModelView()

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
        
        viewModel.callBack = { [weak self] model in
            
            self?.categoryName.text = model.name
            
            if model.imageName != "", let image = UIImage(named: model.imageName)  {
                self?.categoryImage.image = image
            }
        }
        
        viewModel.handleData(with: safeData)
    }
    
}
