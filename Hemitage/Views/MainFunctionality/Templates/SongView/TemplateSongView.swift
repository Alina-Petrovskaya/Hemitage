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
    
    typealias DataType = (title: String, subtitle: String?, isPlaying: Bool, isHideCloseButton: Bool, imageURL: URL?, isCanPlay: Bool, isSaved: Bool)

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var singerLabel: UILabel!
    @IBOutlet private weak var imageSong: UIImageView!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var topBorder: UIView!
    
    private var isCanPlay: Bool = true
    
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
        isCanPlay            = data.isCanPlay
        imageSong.sd_setImage(with: data.imageURL, placeholderImage: #imageLiteral(resourceName: "Picture Placeholder"), options: [.delayPlaceholder], context: nil)
                  
        
        let imageForPlayButton = data.isPlaying ? UIImage(systemName: "pause") : UIImage(systemName: "play")
        playButton.setImage(imageForPlayButton, for: .normal)
        
        contentView.alpha = isCanPlay ? 1 : 0.5
        
        let saveButtonImageName = data.isSaved ? "trash" : "arrow.down.circle"
        saveButton.tintColor = data.isSaved ? #colorLiteral(red: 0.09411764706, green: 0.09803921569, blue: 0.1019607843, alpha: 1) : #colorLiteral(red: 0.902816236, green: 0.729167521, blue: 0.6777408719, alpha: 1)
        saveButton.setImage(UIImage(systemName: saveButtonImageName), for: .normal)
    }
    
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        if isCanPlay {
            let nameImageForButton = sender.currentImage == UIImage(systemName: "pause") ? "play" : "pause"
            sender.setImage(UIImage(systemName: nameImageForButton), for: .normal)
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if isCanPlay {
            let saveButtonImageName = sender.currentImage == UIImage(systemName: "arrow.down.circle")
                ? "trash"
                : "arrow.down.circle"
            
            saveButton.setImage(UIImage(systemName: saveButtonImageName), for: .normal)
            saveButton.tintColor = saveButton.image(for: .normal) == UIImage(systemName: "arrow.down.circle") ? #colorLiteral(red: 0.902816236, green: 0.729167521, blue: 0.6777408719, alpha: 1) : #colorLiteral(red: 0.09411764706, green: 0.09803921569, blue: 0.1019607843, alpha: 1)
            
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        //self.isHidden = true
    }
    
}
