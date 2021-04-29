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
    private let rootController = AppDelegate.shared.rootViewController
    private var kvoResultOfLogin: NSKeyValueObservation?
    private var kvoErrorMessage: NSKeyValueObservation?
    private let loginViewModel: NSObject & LoginViewModelProtocol = LoginViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareLocalizedText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observe(viewModel: loginViewModel)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        kvoResultOfLogin?.invalidate()
        kvoErrorMessage?.invalidate()
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
    
    
    func observe<T: NSObject & LoginViewModelProtocol>(viewModel: T) {
        kvoResultOfLogin = viewModel.observe(\.loginResult, options: .new, changeHandler: { _, result in
            guard result.newValue != nil else { return }
            print("success loged in with result")
        })
        
        kvoErrorMessage = viewModel.observe(\.errorMessage, options: .new, changeHandler: { [weak self] _, error in
            guard let errorMessage = error.newValue,
                  let message = errorMessage else { return }
            
            self?.showErrorAlert(with: message)
        })
    }
}
