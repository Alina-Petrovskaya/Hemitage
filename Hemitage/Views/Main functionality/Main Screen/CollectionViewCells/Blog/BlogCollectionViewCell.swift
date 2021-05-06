//
//  BlogCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class BlogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageBlog: UIImageView!
    @IBOutlet weak var articleName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var articlePreview: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateUI() {
        imageBlog.layer.cornerRadius = 16
        
        
    }
}
