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
    @IBOutlet weak private var scrollView: UIScrollView!
    
    private var viewModel: SignInViewModelProtocol = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate     = self
        emailField.delegate    = self
        passwordField.delegate = self
        
        prepareLocalizedText()
        prepareUI()
    }
    
    private func prepareUI() {
        signInButton.layer.cornerRadius = 8
        
        viewModel.keyBoardCallBack = { [weak self] keyboardHeight in
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self?.scrollView.contentInset = inset
            self?.scrollView.scrollIndicatorInsets = inset
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
                         name: nameField.text) { [weak self] result in
            
            switch result {
            case .success(let result):
                print(result)
                
            case .failure(let error):
                self?.showErrorAlert(with: error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if nameField.isFirstResponder {
            emailField.becomeFirstResponder()
            
        } else if emailField.isFirstResponder {
            passwordField.becomeFirstResponder()
            
        } else {
            view.endEditing(true)
        }
        return true
    }
}
