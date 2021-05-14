//
//  MainScreenViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation


protocol MainScreenViewModelProtocol {
    
    var itemsInserted: (((items: [MainScreenModelWrapper], section: MainScreenTypeOfSection)) -> ())? { get set }
    var itemsReloaded: (([MainScreenModelWrapper]) -> ())? { get set }
    var itemsDeleted:  (([MainScreenModelWrapper]) -> ())? { get set }
    
    func getSectionContent(for sectionType: MainScreenTypeOfSection) -> [MainScreenModelWrapper]
    func getItem(for indexPath: IndexPath) -> MainScreenModelWrapper?
}


class MainScreenViewModel: MainScreenViewModelProtocol {
    
    var itemsInserted: (((items: [MainScreenModelWrapper], section: MainScreenTypeOfSection)) -> ())?
    var itemsReloaded: (([MainScreenModelWrapper]) -> ())?
    var itemsDeleted: (([MainScreenModelWrapper]) -> ())?
    
    // Get data
    private var mapData: [MainScreenModelWrapper] = [MainScreenModelWrapper.map(MapModel(allUsers: 15, usersOnline: 5))]
    
    private var categoriesdata: [MainScreenModelWrapper] = [
        MainScreenModelWrapper.category(CategoriesModel(imageName: "Meditation", name: "Meditation")),
        MainScreenModelWrapper.category(CategoriesModel(imageName: "Sleep", name: "Sleep")),
        MainScreenModelWrapper.category(CategoriesModel(imageName: "forest", name: "Mid-Day Relaxation"))
    ]
    
    private var blogData: [MainScreenModelWrapper] = [
        MainScreenModelWrapper.blog(BlogModel(id: 1, imageName:  "river", title: "One", preview: "Praesent eu dolor eu orci vehicula euismod. Vivamus sed sollicitudin libero, vel malesuada velit. Nullam...", date: "11.12.2020", text: "")) ,
        MainScreenModelWrapper.blog(BlogModel(id: 2, imageName:  "", title: "Two", preview: "Praesent eu dolor eu orci vehicula euismod. Vivamus sed sollicitudin libero, vel malesuada velit. Nullam...", date: "10.12.2020", text: "")),
        MainScreenModelWrapper.blog(BlogModel(id: 3, imageName:  "forest", title: "Etiam vivamus", preview: "Praesent eu dolor eu orci vehicula euismod. Vivamus sed sollicitudin libero, vel malesuada velit. Nullam...", date: "4.07.2020", text: ""))
     ]

    
    // Actions
    func getSectionContent(for sectionType: MainScreenTypeOfSection) -> [MainScreenModelWrapper] {
        switch sectionType {
        case .map:
            return mapData
            
        case .categories:
            return categoriesdata
            
        case .blog:
            return blogData
        }
    }
    
    
    func getItem(for indexPath: IndexPath) -> MainScreenModelWrapper? {
        guard let section = MainScreenTypeOfSection(rawValue: indexPath.section) else { return nil }
        
        switch section {
        case .map:
            return mapData[indexPath.row]
            
        case .categories:
            return categoriesdata[indexPath.row]
            
        case .blog:
            return blogData[indexPath.row]
        }
    }
    
    
    private func getDifferensesToUpdate() {
        
//        itemsInserted?(((items: data, section: .blog))
//        itemsReloaded?(data)
//        itemsDeleted?(dara)
        
    }
}

