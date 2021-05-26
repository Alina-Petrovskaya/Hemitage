//
//  LoginViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 27.04.2021.
//

import UIKit

class LoginViewController: UIViewController, AuthObserver, KeyboardStateObserver {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var resetPasswordLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let loginViewModel: NSObject & LoginProtocol = LoginViewModel()
    
    var kvoResultOfLogin: NSKeyValueObservation?
    var kvoErrorMessage: NSKeyValueObservation?
    var kvoKeyboardHeight: NSKeyValueObservation?
    
    var keyboardHeight: CGFloat = 0 {
        didSet {
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.contentInset = inset
            scrollView.scrollIndicatorInsets = inset
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareLocalizedText()
        
        emailField.delegate    = self
        passwordField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observeAuth(viewModel: loginViewModel, false)
        observeKeyBoard(viewModel: loginViewModel as? NSObject & KeyboardManagerPorotocol)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        kvoResultOfLogin?.invalidate()
        kvoErrorMessage?.invalidate()
        kvoKeyboardHeight?.invalidate()
    }
    
    private func prepareUI() {
        loginButton.layer.cornerRadius = 8
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
        if let vc = SignInViewController.instantiate() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        if let vc = PasscodeRecoveryViewController.instantiate() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        loginViewModel.login(email: emailField.text,
                             password: passwordField.text,
                             autorizationType: .email)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if emailField.isFirstResponder {
            passwordField.becomeFirstResponder()
            
        } else {
            view.endEditing(true)
        }
        return true
    }
}
