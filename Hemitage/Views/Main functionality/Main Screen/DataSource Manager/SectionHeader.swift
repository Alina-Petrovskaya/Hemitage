//
//  SectionHeader.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 07.05.2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    let title: UILabel = {
        let title = UILabel()
        
        title.textColor     = UIColor(named: Constants.Colors.darkText)
        title.font          = Constants.FontBook.interSemiBold.of(size: 20)
        title.textAlignment = .left
        
        return title
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("All see", for: .normal)
        button.setTitleColor(UIColor(named: Constants.Colors.mainColor), for: .normal)
        button.titleLabel?.font = Constants.FontBook.interSemiBold.of(size: 13)
        button.titleLabel?.textAlignment = .right
        button.isHidden = true
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for SectionHeader")
    }
    
    private func configureUI() {
        
        let stakView  = UIStackView(arrangedSubviews: [title, button])
        stakView.axis = .horizontal
        stakView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stakView)
        
        NSLayoutConstraint.activate([
            stakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stakView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stakView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stakView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
