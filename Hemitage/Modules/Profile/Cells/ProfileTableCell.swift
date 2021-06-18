//
//  ProfileTableCell.swift
//  Hemitage
//
//  Created by Vladislav Pavlenko on 18.06.2021.
//

import UIKit

class ProfileTableCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    private func initialSetup() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    func configure(with viewModel: ProfileTableCellViewModel) {
        
    }
    
}
