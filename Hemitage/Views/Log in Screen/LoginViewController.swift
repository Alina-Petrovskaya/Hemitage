//
//  LoginViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 27.04.2021.
//

import UIKit

class LoginViewController: AuthorizationViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var resetPasswordLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    private let loginViewModel: NSObject & LoginViewModelProtocol = LoginViewModel()
    
    override var keyboardHeight: CGFloat? {
        didSet {
            guard let height = keyboardHeight else { return }
           
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            scrollView.contentInset = inset
            scrollView.scrollIndicatorInsets = inset
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareLocalizedText()
        
        emailField.delegate    = self
        passwordField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observe(viewModel: loginViewModel)
        
    }
    
    private func prepareUI() {
        loginButton.layer.cornerRadius = 8
        
        emailField.setLeftView(with: "envelope")
        passwordField.setLeftView(with: "lock")
        passwordField.setRightButtonForPasswordfield()
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
        if let vc = rootController.goToNextController(.signInVC) as? SignInViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        
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
