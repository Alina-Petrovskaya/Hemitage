//
//  WelcomeViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.04.2021.
//

import UIKit

class WelcomeViewController: UIViewController, AuthObserver {
    
    @IBOutlet var signInButtons: [UIButton]!
    @IBOutlet weak var welcomLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let welcomeViewModel: NSObject & LoginViewModelProtocol = WelcomeViewModel()
    var kvoResultOfLogin: NSKeyValueObservation?
    var kvoErrorMessage: NSKeyValueObservation?
    var kvoKeyboardHeight: NSKeyValueObservation?
    var keyboardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareLocalizedText()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        kvoResultOfLogin?.invalidate()
        kvoErrorMessage?.invalidate()
        kvoKeyboardHeight?.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        observeAuth(viewModel: welcomeViewModel)
    }
    
    private func prepareUI() {
        signInButtons.forEach { $0.layer.cornerRadius = 8 }
    }
    
    private func prepareLocalizedText() {
        welcomLabel.text = NSLocalizedString("welcome_label", comment: "")
        descriptionLabel.text = NSLocalizedString("description_label", comment: "")
    }
    
    @IBAction func loginWithEmailTapped(_ sender: UIButton) {
        if let vc = LoginViewController.instantiate() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func signinWithAppleTapped(_ sender: UIButton) {
        welcomeViewModel.login(email: nil, password: nil, autorizationType: .apple)
    }
    
    
    @IBAction func signInWithFBTapped(_ sender: UIButton) {
        welcomeViewModel.login(email: nil, password: nil, autorizationType: .facebook)
    }
}


