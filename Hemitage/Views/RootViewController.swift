//
//  RootViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.04.2021.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        goToWelcomeController()
    }

    func goToWelcomeController() {
        guard let vc = SignInViewController.getNextViewController()
        else {
            print("Can't create path to next VCb")
            return
        }
        
       // let nVC = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(nVC, animated: true)
    }
}
