//
//  TemplateHeaderView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

@IBDesignable
class TemplateHeaderView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var notificationIndicator: UIView! 
    @IBOutlet weak var profilePhoto: UIImageView!
    
    var viewModel: some TemplatesViewModelProtocol = ViewModelTemplateHeader()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    

    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: TemplateHeaderView.self), owner: self)
        configureUI()
        configureContent()
        
        viewModel.getDataForContent()
    }
    
    private func configureUI() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.height / 2
        notificationIndicator.layer.cornerRadius = notificationIndicator.frame.size.height / 2
    }
    
    private func configureContent() {
        viewModel.dataModel = { [weak self] model in
            guard let safeModel = model as? ProfileModel else { return }

            self?.welcomeLabel.text              = safeModel.name
            self?.notificationIndicator.isHidden = safeModel.isNewNotificatoins

            if safeModel.imageName != "", let image = UIImage(named: safeModel.imageName) {
                self?.profilePhoto.image = image
            }
        }
    }

    // MARK: - Actions
    @IBAction func notificationsButtonTapped(_ sender: UIButton) {
        notificationIndicator.isHidden = !notificationIndicator.isHidden
    }
  
}
