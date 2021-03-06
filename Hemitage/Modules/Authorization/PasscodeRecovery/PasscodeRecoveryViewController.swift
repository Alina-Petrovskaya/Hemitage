//
//  PasscodeRecoveryViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 24.05.2021.
//

import UIKit

class PasscodeRecoveryViewController: UIViewController, KeyboardStateObserver, PasswordRecoveryObserver {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let viewModel: NSObject & PasscodeRecoveryViewModelProtocol = PasscodeRecoveryViewModel()
    
    var kvoKeyboardHeight: NSKeyValueObservation?
    var kvoSuccesResult: NSKeyValueObservation?
    var kvoErrorMessage: NSKeyValueObservation?
    
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
        prepareContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observeKeyBoard(viewModel: viewModel as? NSObject & KeyboardManagerPorotocol)
        observePasscodedManager(viewModel: viewModel as? NSObject & PasswordManagerProtocol)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
        kvoKeyboardHeight?.invalidate()
        kvoSuccesResult?.invalidate()
        kvoErrorMessage?.invalidate()
    }
    

    private func prepareUI() {
        resetButton.layer.cornerRadius = 8
        navigationController?.navigationBar.isHidden = true
    }
    
    
    private func prepareContent() {
        titleLabel.text    = NSLocalizedString("passcode_recovery_title", comment: "")
        subtitleLabel.text = NSLocalizedString("passcode_recovery_subtitle", comment: "")

        resetButton.setTitle(NSLocalizedString("passcode_recovery_reset_button", comment: ""), for: .normal)
    }
    
    
    // MARK: - Actions
    @IBAction func resetButtonTupped(_ sender: UIButton) {
        viewModel.getNewPassword(for: emailTextField.text)
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
