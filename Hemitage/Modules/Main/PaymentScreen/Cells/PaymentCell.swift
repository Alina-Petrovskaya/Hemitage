//
//  PaymentCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 18.06.2021.
//

import UIKit
import SDWebImage

class PaymentCell: UITableViewCell {
    
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var buyButton: UIButton!
    
    var buyButtonTapped: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure<T: ViewModelConfigurator>(with viewModel: T) {
        
        guard let data = (viewModel as? PaymentCellViewModel)?.getData() else { return }
        
        titleLabel.text = data.title
        priceLabel.text = data.price
        productImage.sd_setImage(with: data.image, placeholderImage: #imageLiteral(resourceName: "Picture Placeholder"), options: [.delayPlaceholder], context: nil)
        
    }
    
    
    private func initialSetup() {
        buyButton.layer.cornerRadius = 8
        
        view.layer.cornerRadius      = 20
        view.layer.borderWidth       = 2
        view.layer.borderColor       = #colorLiteral(red: 0.9165850282, green: 0.760902822, blue: 0.7074727416, alpha: 1)
    }
    
    
    @IBAction private func buyButtonTapped(_ sender: UIButton) {
        buyButtonTapped?()
    }
    
}
