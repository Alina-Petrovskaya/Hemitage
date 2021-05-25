//
//  PasscodeRecoveryViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 24.05.2021.
//

import UIKit

class PasscodeRecoveryViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        prepareContent()
    }
    

    private func prepareUI() {
        resetButton.layer.cornerRadius = 8
    }
    
    
    private func prepareContent() {
        titleLabel.text    = NSLocalizedString("passcode_recovery_title", comment: "")
        subtitleLabel.text = NSLocalizedString("passcode_recovery_subtitle", comment: "")

        resetButton.setTitle(NSLocalizedString("passcode_recovery_reset_button", comment: ""), for: .normal)
    }
    
    
    @IBAction func resetButtonTupped(_ sender: UIButton) {
        
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
