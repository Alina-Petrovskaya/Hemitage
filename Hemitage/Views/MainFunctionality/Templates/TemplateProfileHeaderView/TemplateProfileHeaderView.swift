//
//  TemplateProfileHeaderView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

@IBDesignable
class TemplateProfileHeaderView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var notificationIndicator: UIView! 
    @IBOutlet weak var profilePhoto: UIImageView!
    
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
        Bundle.main.loadNibNamed(String(describing: TemplateProfileHeaderView.self), owner: self)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.height / 2
        notificationIndicator.layer.cornerRadius = notificationIndicator.frame.size.height / 2
    }
    
    
    func configureContent<T: ViewModelConfigurator>(with model: T) {
        
        let data = model.getData() as? (name: String, image: String, isNewNotificatoins: Bool)

        welcomeLabel.text              = data?.name
        profilePhoto.image             = UIImage(named: data?.image ?? "user-line")
        notificationIndicator.isHidden = !(data?.isNewNotificatoins ?? false)
    }

    // MARK: - Actions
    @IBAction func notificationsButtonTapped(_ sender: UIButton) {
        notificationIndicator.isHidden = !notificationIndicator.isHidden
    }
  
}
