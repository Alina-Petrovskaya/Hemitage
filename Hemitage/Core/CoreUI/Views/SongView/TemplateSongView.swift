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
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var topBorder: UIView!
    @IBOutlet private weak var saveIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var saveView: UIView!
    
    
    var saveCallback: ((Bool) -> ())?
    var playCallBack: ((Bool) -> ())?
    var stopCallback: (() -> ())?
    
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
        contentView.alpha    = isCanPlay ? 1 : 0.5
        imageSong.sd_setImage(with: data.imageURL, placeholderImage: #imageLiteral(resourceName: "Picture Placeholder"), options: [.delayPlaceholder], context: nil)
        
        updateIcons(isSaved: data.isSaved, isPlaying: data.isPlaying)
    }
    
    
    func updateSongData(with data: DataType) {
        self.isHidden        = false
        topBorder.isHidden   = false
        saveView.isHidden    = true
        
        songNameLabel.text   = data.title
        singerLabel.text     = data.subtitle
        imageSong.sd_setImage(with: data.imageURL, placeholderImage: #imageLiteral(resourceName: "Picture Placeholder"), options: [.delayPlaceholder], context: nil)
        updateIcons(isSaved: nil, isPlaying: data.isPlaying)
        
    }
    
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
            updateIcons(isSaved: nil, isPlaying: sender.currentImage == UIImage(systemName: "play"))
            playCallBack?(isCanPlay)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
            saveButton.isHidden = true
            saveIndicator.isHidden = false
            
            saveCallback?(isCanPlay)
    }
    
    private func updateIcons(isSaved: Bool?, isPlaying: Bool?) {
        if isSaved != nil {
            saveButton.isHidden = false
            saveIndicator.isHidden = true
            
            let saveButtonImage = isSaved! ?  UIImage(systemName: "trash") : UIImage(systemName: "arrow.down.circle")
            
            saveButton.tintColor = isSaved! ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.902816236, green: 0.729167521, blue: 0.6777408719, alpha: 1) 
            saveButton.setImage(saveButtonImage, for: .normal)
        }
        
        if isPlaying != nil {
            let playButtonImage = isPlaying! ? UIImage(systemName: "pause") : UIImage(systemName: "play")
            playButton.setImage(playButtonImage, for: .normal)
        }
        
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.isHidden = true
        stopCallback?()
    }
    
}
