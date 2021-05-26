//
//  NewPasscodeViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.05.2021.
//

import UIKit

class NewPasscodeViewController: UIViewController {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var firstPasswordField: UITextField!
    @IBOutlet weak private var secondPasswordField: UITextField!
    @IBOutlet weak private var resetButton: UIButton!
    
    var email: String?
    var obbcode: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        prepareContent()
    }
    
    
    
    func prepareUI() {
        resetButton.layer.cornerRadius = 8
    }
    
    
    func prepareContent() {
        
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
}
