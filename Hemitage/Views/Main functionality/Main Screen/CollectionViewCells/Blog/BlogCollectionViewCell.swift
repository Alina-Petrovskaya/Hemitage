//
//  BlogCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class BlogCollectionViewCell: UICollectionViewCell, ContentViewConstructor {
    
    @IBOutlet private weak var imageBlog: UIImageView!
    @IBOutlet private weak var articleName: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var articlePreview: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageBlog.layer.cornerRadius = 16
    }
    
    func updateContent<T>(with data: T) {
        guard let safeData = data as? MainScreenModel else { return }
        
        switch safeData {
        case .map(_):
            break
        case .category(_):
            break
        case .blog(let data):
            articleName.text    = data.title
            articlePreview.text = data.preview
            date.text           = data.date
            imageBlog.isHidden  = false

            
            if data.imageName != "",  let image = UIImage(named: "\(data.imageName)")  {
                imageBlog.image = image
            } else {
                imageBlog.isHidden = true
            }
        }
    }
}
