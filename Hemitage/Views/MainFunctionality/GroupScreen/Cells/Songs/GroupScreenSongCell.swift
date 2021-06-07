//
//  GroupScreenSongCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 04.06.2021.
//

import UIKit

class GroupScreenSongCell: UITableViewCell, ConfiguringCell {

    @IBOutlet weak var songView: TemplateSongView!
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    
    func updateContent<T>(with viewModel: T) {
        guard let model = viewModel as? ViewModelTemplateSong else { return }
        songView.updateUI(with: model.getData())
        
    }
    
}
