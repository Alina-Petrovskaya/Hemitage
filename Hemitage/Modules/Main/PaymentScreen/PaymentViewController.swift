//
//  PaymentViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 09.06.2021.
//

import UIKit

class PaymentViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var byeButton: [UIButton]!
    @IBOutlet var borderViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        prepareUI()
    }
    
    private func prepareUI() {
        byeButton.forEach { button in
            button.layer.cornerRadius = 8
        }
        
        borderViews.forEach { view in
            view.layer.borderWidth  = 2
            view.layer.borderColor  = #colorLiteral(red: 0.902816236, green: 0.729167521, blue: 0.6777408719, alpha: 1)
            view.layer.cornerRadius = 40
        }
    }
    
    @IBAction func pageControllChanged(_ sender: UIPageControl) {
        let currentPage = CGFloat(sender.currentPage) * view.frame.size.width
        scrollView.setContentOffset(CGPoint(x: currentPage, y: 0), animated: true)
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = Float(scrollView.contentOffset.x)
        let scrollViewWidth = Float(scrollView.frame.size.width)
        
        pageControl.currentPage = Int(contentOffset / scrollViewWidth)
    }
    
}
