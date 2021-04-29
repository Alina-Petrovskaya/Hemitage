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
    let rootController = AppDelegate.shared.rootViewController
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareLocalizedText()
    }

    private func prepareUI() {
        signInButtons.forEach { $0.layer.cornerRadius = 8 }
        navigationController?.navigationBar.isHidden = true
    }
    
    private func prepareLocalizedText() {
        welcomLabel.text = NSLocalizedString("welcome_label", comment: "")
        descriptionLabel.text = NSLocalizedString("description_label", comment: "")
    }
    
    @IBAction func loginWithEmailTapped(_ sender: UIButton) {
        if let vc = rootController.goToNextController(.loginVC) as? LoginViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func signinWithAppleTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func signInWithFBTapped(_ sender: UIButton) {
    }
}


