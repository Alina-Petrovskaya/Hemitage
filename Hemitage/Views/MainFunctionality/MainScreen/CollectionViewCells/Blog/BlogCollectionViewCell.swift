//
//  BlogCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class BlogCollectionViewCell: UICollectionViewCell, ConfiguringCell {
    
    @IBOutlet private weak var imageBlog: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var subtitle: UILabel!
    
    var viewModel: BlogCollectionViewCellModelViewProtocol = BlogCollectionViewCellModelView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageBlog.layer.cornerRadius = 16
    }
    
    func updateContent<T>(with data: T) {
        guard let safeData = data as? MainScreenModelWrapper else { return }
        
        imageBlog.isHidden = false
        viewModel.callBack = { [weak self] model in
        }
        
        viewModel.handleData(with: safeData)
    }
}
