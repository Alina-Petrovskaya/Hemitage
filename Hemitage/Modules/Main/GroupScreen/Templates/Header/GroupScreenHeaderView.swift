//
//  Test.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 08.06.2021.
//

import UIKit

@IBDesignable
class GroupScreenHeaderView: UIView {

    var callBack: ((GroupScreenTypeOfContent) -> ())?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private var parrentView: UIView!
    @IBOutlet weak var contentSwitcher: UISegmentedControl!
    
    // MARK: - Life cycle'
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: GroupScreenHeaderView.self), owner: self)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(parrentView)
        parrentView.frame = self.bounds
        
        contentSwitcher.setTitleTextAttributes([.foregroundColor: UIColor(ciColor: .white)],
                                               for: .selected)
        
        contentSwitcher.setTitleTextAttributes([.foregroundColor: UIColor(named: Constants.Colors.darkText) ?? UIColor(ciColor: .black)],
                                               for: .normal)
        
    }
    
    @IBAction func stateChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            callBack?(.songList)
            
        } else {
            callBack?(.premiumContent)
        }
    }
    
}
