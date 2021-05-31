//
//  NewPasscodeViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.05.2021.
//

import UIKit

class NewPasscodeViewController: UIViewController, KeyboardStateObserver, AuthObserver {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var firstPasswordField: UITextField!
    @IBOutlet weak private var secondPasswordField: UITextField!
    @IBOutlet weak private var resetButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var kvoResultOfLogin: NSKeyValueObservation?
    var kvoErrorMessage: NSKeyValueObservation?
    var kvoKeyboardHeight: NSKeyValueObservation?
   
    var viewModel: (NSObject & NewPasscodeViewModelProtocol)?
    
    var keyboardHeight: CGFloat = 0 {
        didSet {
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.contentInset = inset
            scrollView.scrollIndicatorInsets = inset
        }
    }
    
    
    // MARK: - Lifi Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        prepareContent()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observeKeyBoard(viewModel: viewModel as? NSObject & KeyboardManagerPorotocol)
        observeAuth(viewModel: viewModel as? NSObject & AuthProtocol, true)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        kvoResultOfLogin?.invalidate()
        kvoErrorMessage?.invalidate()
        kvoKeyboardHeight?.invalidate()
    }
    
    
    func prepareUI() {
        resetButton.layer.cornerRadius = 8
    }
    
    
    func prepareContent() {
        titleLabel.text = NSLocalizedString("new_passcode_title", comment: "")
        firstPasswordField.placeholder = NSLocalizedString("new_passcode_first_textfield", comment: "")
        secondPasswordField.placeholder = NSLocalizedString("new_passcode_second_textfield", comment: "")
        
        resetButton.setTitle(NSLocalizedString("new_passcode_reset_button", comment: ""), for: .normal)
    }
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        viewModel?.setNewPassword(firstPassword: firstPasswordField.text, secondPassword: secondPasswordField.text)
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
