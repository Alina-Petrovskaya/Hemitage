//
//  BlogCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class BlogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageBlog: UIImageView!
    @IBOutlet private weak var articleName: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var articlePreview: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageBlog.layer.cornerRadius = 16
    }
    
    func preparecontent(image: UIImage?, name: String, articleDate: String, shotDescription: String) {
        
        articleName.text    = name
        date.text           = articleDate
        articlePreview.text = shotDescription
        
        if image != nil {
            imageBlog.image = image
        } else {
            imageBlog.isHidden = true
        }
    }
}
