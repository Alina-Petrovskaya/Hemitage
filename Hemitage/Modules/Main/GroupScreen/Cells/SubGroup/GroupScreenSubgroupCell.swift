//
//  GroupScreenSubgroupCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import UIKit

class GroupScreenSubgroupCell: UICollectionViewCell, ConfiguringCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var title: UILabel!
    
    
    override var isSelected: Bool {
            didSet {
                view.backgroundColor = isSelected ? UIColor(named: Constants.Colors.mainColor) : .white
                title.textColor = isSelected ? .white : .black
                view.layer.borderColor = isSelected ? #colorLiteral(red: 0.902816236, green: 0.729167521, blue: 0.6777408719, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 8
        
    }
    
    
    func updateContent<T>(with viewModel: T) {
        guard let safeViewModel = viewModel as? GroupScreenSubgroupCellViewModel else { return }
        
        let data = safeViewModel.getData()
        title.text = data.title
    }

}
