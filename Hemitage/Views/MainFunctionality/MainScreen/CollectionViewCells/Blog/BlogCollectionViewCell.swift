//
//  BlogCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class BlogCollectionViewCell: UICollectionViewCell, ConfiguringCell {
    
    @IBOutlet private weak var imageBlog: UIImageView!
    @IBOutlet private weak var articleName: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var articlePreview: UILabel!
    
    var viewModel: BlogCollectionViewCellModelViewProtocol = BlogCollectionViewCellModelView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageBlog.layer.cornerRadius = 16
    }
    
    func updateContent<T>(with data: T) {
        guard let safeData = data as? MainScreenModelWrapper else { return }
        
        imageBlog.isHidden = false
        
        viewModel.callBack = { [weak self] model in
            
            self?.articleName.text    = model.title
            self?.articlePreview.text = model.preview
            self?.date.text           = model.date
        
            if model.imageName != "",  let image = UIImage(named: model.imageName)  {
                self?.imageBlog.image = image
            } else {
                self?.imageBlog.isHidden = true
            }
        }
        
        viewModel.handleData(with: safeData)
    }
}
