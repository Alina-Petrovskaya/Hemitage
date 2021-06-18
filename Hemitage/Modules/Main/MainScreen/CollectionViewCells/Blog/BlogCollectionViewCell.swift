//
//  BlogCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit
import SDWebImage

class BlogCollectionViewCell: UICollectionViewCell, ConfiguringCell {
    
    @IBOutlet private weak var imageBlog: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var subtitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageBlog.layer.cornerRadius = 16
    }
    
    func updateContent<T>(with viewModel: T) {
        guard let safeViewModel: MainScreenCollectionViewCellModelViewProtocol = viewModel as? BlogCollectionViewCellModelView
        else { return }
        
        let data: (id: String, title: String, subtitle: String?, date: String, imageData: Data?) = safeViewModel.getData()
        
        title.text = data.title
        subtitle.text = data.subtitle
        date.text = data.date
      
        
        if let imageData = data.imageData {
            imageBlog.image = UIImage(data: imageData)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageBlog.image = #imageLiteral(resourceName: "Picture Placeholder")
        title.text      = ""
        date.text       = ""
        subtitle.text   = ""
    }
}
