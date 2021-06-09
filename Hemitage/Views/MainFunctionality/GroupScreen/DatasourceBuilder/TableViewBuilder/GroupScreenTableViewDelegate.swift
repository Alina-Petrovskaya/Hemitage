//
//  GroupScreenTableViewDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 08.06.2021.
//

import UIKit


protocol GroupScreenTableDelegateProtocol {
    
    var rowTapped: ((Int) -> ())? { get set }
    var requestForMoreItems: (() -> ())? { get set }
    var tableView: UITableView { get }
    var canLoadMoreData: Bool { get set }
    var subGroup: String { get set }
    
}

class GroupScreenTableViewDelegate: NSObject, UITableViewDelegate, GroupScreenTableDelegateProtocol {
    
    var rowTapped: ((Int) -> ())?
    var requestForMoreItems: (() -> ())?
    
    private let headerView = GroupScreenHeaderView(frame: .zero)
    
    let tableView: UITableView
    var canLoadMoreData = false
    var subGroup: String = "Popular" {
        didSet {
            headerView.titleLabel.text = subGroup
        }
    }
    
    init(with tableView: UITableView) {
        self.tableView     = tableView
        super.init()
        
        tableView.delegate = self
    }
    
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        if position > (tableView.contentSize.height - scrollView.frame.size.height), canLoadMoreData {
            canLoadMoreData = false
            tableView.tableFooterView = GroupScreenFooterView(frame: .zero)
            
            requestForMoreItems?()
        }
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.estimatedSectionHeaderHeight
    }

    @objc func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowTapped?(indexPath.row)
    }
}
