//
//  LoginViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 27.04.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var resetPasswordLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    let rootController = AppDelegate.shared.rootViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareLocalizedText()
    }
    
    private func prepareUI() {
        loginButton.layer.cornerRadius = 8
        emailField.setLeftView(with: "envelope")
        passwordField.setLeftView(with: "lock")
        passwordField.setRightButtonForPasswordfield()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        rootController.currentController = self
    }
    
    private func prepareLocalizedText() {
        //Labels
        welcomeLabel.text       = NSLocalizedString("welcome_login_label", comment: "")
        createAccountLabel.text = NSLocalizedString("create_ccount_label", comment: "")
        resetPasswordLabel.text = NSLocalizedString("reset_password_label", comment: "")
       
        
        //TextFields
        emailField.placeholder    = NSLocalizedString("email_field", comment: "")
        passwordField.placeholder = NSLocalizedString("password_field", comment: "")
        
        
        //Buttons
        createAccountButton.setTitle(NSLocalizedString("create_account_button", comment: ""), for: .normal)
        resetPasswordButton.setTitle(NSLocalizedString("reset_password_button", comment: ""), for: .normal)
        loginButton.setTitle(NSLocalizedString("login_button", comment: ""), for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        rootController.goToNextController(.signInVC)
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
