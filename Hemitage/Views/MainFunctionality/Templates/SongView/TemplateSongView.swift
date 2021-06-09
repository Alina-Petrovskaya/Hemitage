//
//  TemplateSongView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit
import SDWebImage

@IBDesignable
class TemplateSongView: UIView {
    
    typealias DataType = (title: String, subtitle: String?, isPlaying: Bool, isHideCloseButton: Bool, imageURL: URL?)

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var singerLabel: UILabel!
    @IBOutlet private weak var imageSong: UIImageView!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet weak var topBorder: UIView!
    
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
        Bundle.main.loadNibNamed(String(describing: TemplateSongView.self), owner: self)
        configureUI()
    }
    
    
    private func configureUI() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        imageSong.layer.cornerRadius = 8
    }

    
    // MARK: - Actions
    func updateUI(with data: DataType) {
      
        songNameLabel.text   = data.title
        singerLabel.text     = data.subtitle
        closeButton.isHidden = data.isHideCloseButton
        imageSong.sd_setImage(with: data.imageURL, placeholderImage: #imageLiteral(resourceName: "Picture Placeholder"), options: [.delayPlaceholder], context: nil)
        
        //let imageForPlayButton = data.isPlaying ? UIImage(named: "play") : UIImage(named: "pause")
        //playButton.setImage(imageForPlayButton, for: .normal)
    }
    
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        let nameImageForButton = sender.currentImage == UIImage(systemName: "pause") ? "play" : "pause"
        sender.setImage(UIImage(systemName: nameImageForButton), for: .normal)
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        //self.isHidden = true
    }
}
