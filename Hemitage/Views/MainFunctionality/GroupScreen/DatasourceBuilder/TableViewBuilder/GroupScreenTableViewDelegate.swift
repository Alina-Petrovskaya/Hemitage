//
//  GroupScreenTableViewDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 08.06.2021.
//

import UIKit

protocol GroupScreenTableDelegateProtocol {
    
    var interactionCallback: ((SongTemplateTypeOfInteraction) -> ())? { get set }
    var tableView: UITableView { get }
    var canLoadMoreData: Bool { get set }
    var currentSongScreen: GroupScreenTypeOfContent { get }
    
}

class GroupScreenTableViewDelegate: NSObject, UITableViewDelegate, GroupScreenTableDelegateProtocol {
    
    var interactionCallback: ((SongTemplateTypeOfInteraction) -> ())?
    
    let tableView: UITableView
    var canLoadMoreData = false
    var currentSongScreen: GroupScreenTypeOfContent = .songList
    private let headerView = GroupScreenHeaderView(frame: .zero)
    
    
    init(with tableView: UITableView) {
        self.tableView     = tableView
        super.init()
        
        tableView.delegate = self
        
        headerView.callBack = { [weak self] state in
            self?.currentSongScreen = state
            self?.interactionCallback?(.reload(0, state))
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (tableView.contentSize.height - scrollView.frame.size.height), canLoadMoreData {
            canLoadMoreData = false
            tableView.tableFooterView = GroupScreenFooterView(frame: .zero)
            
            interactionCallback?(.requestForMoreItems(currentSongScreen))
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.estimatedSectionHeaderHeight
    }
    
    @objc func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactionCallback?(.showDetail(indexPath.row, currentSongScreen))
    }
}
