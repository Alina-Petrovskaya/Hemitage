//
//  WelcomeViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.04.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var signInButtons: [UIButton]!
    @IBOutlet weak var welcomLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }


    private func prepareUI() {
        signInButtons.forEach { $0.layer.cornerRadius = 8 }
        
    }
    
    private func prepareScreenText() {
        welcomLabel.text = NSLocalizedString("welcome_label",
                                             comment: "")
        descriptionLabel.text = NSLocalizedString("description_label",
                                                  comment: "")
    }
}


