//
//  SignInViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 27.04.2021.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak private var welcomeLabel: UILabel!
    @IBOutlet weak private var loginLabel: UILabel!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var nameField: UITextField!
    @IBOutlet weak private var emailField: UITextField!
    @IBOutlet weak private var passwordField: UITextField!
    @IBOutlet weak private var signInButton: UIButton!
    
    
    let viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate     = self
        emailField.delegate    = self
        passwordField.delegate = self
        
        prepareLocalizedText()
        prepareUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameField.becomeFirstResponder()
    }
    
    
    private func prepareUI() {
        signInButton.layer.cornerRadius = 8
        
        emailField.setLeftView(with: "envelope")
        passwordField.setLeftView(with: "lock")
        nameField.setLeftView(with: "person")
        passwordField.setRightButtonForPasswordfield()
        
        
        viewModel.keyBoardCallBack = { [weak self] keyboardHeight in
            guard let self = self else { return }
            self.view.frame = CGRect(x: 0,
                                     y: -keyboardHeight,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height)
        }
    }
    
    private func prepareLocalizedText() {
        //Labels
        welcomeLabel.text = NSLocalizedString("welcome_signin_label", comment: "")
        loginLabel.text   = NSLocalizedString("login_label", comment: "")
        
        //TextFields
        nameField.placeholder     = NSLocalizedString("name_text_field", comment: "")
        emailField.placeholder    = NSLocalizedString("email_text_field", comment: "")
        passwordField.placeholder = NSLocalizedString("password_text_field", comment: "")
        
        //Buttons
        loginButton.setTitle(NSLocalizedString("login_button", comment: ""), for: .normal)
        signInButton.setTitle(NSLocalizedString("sign_in_button", comment: ""), for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func signInTapped(_ sender: UIButton) {
        
        viewModel.signIn(email: emailField.text,
                         password: passwordField.text,
                         name: nameField.text) { result in
            
            switch result {
            case .success(let result):
                print(result)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
