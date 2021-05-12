//
//  DatasourceManagerMainScreenProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import UIKit

protocol MainScreenModelViewProtocol {
    
    func getSectionContent(for sectionType: MainScreenTypeOfSection) -> [MainScreenModelWrapper]
    func getHeaderView(for view: MainScreenHeaderView, at section: MainScreenTypeOfSection) -> UICollectionReusableView?
}

class MainScreenViewModel: MainScreenModelViewProtocol {
    
    private var mapData: [MainScreenModelWrapper] = [MainScreenModelWrapper.map(MapModel(allUsers: 15, usersOnline: 5))]
    
    private var categoriesdata: [MainScreenModelWrapper] = [
        MainScreenModelWrapper.category(CategoriesModel(imageName: "Meditation", name: "Meditation")),
        MainScreenModelWrapper.category(CategoriesModel(imageName: "Sleep", name: "Sleep")),
        MainScreenModelWrapper.category(CategoriesModel(imageName: "forest", name: "Mid-Day Relaxation"))
    ]
    
     private var blogData: [MainScreenModelWrapper] = [
        MainScreenModelWrapper.blog(BlogModel(imageName:  "river", title: "One", preview: "Praesent eu dolor eu orci vehicula euismod. Vivamus sed sollicitudin libero, vel malesuada velit. Nullam...", date: "11.12.2020", text: "")) ,
        MainScreenModelWrapper.blog(BlogModel(imageName:  "", title: "Two", preview: "Praesent eu dolor eu orci vehicula euismod. Vivamus sed sollicitudin libero, vel malesuada velit. Nullam...", date: "10.12.2020", text: "")),
        MainScreenModelWrapper.blog(BlogModel(imageName:  "forest", title: "Etiam vivamus", preview: "Praesent eu dolor eu orci vehicula euismod. Vivamus sed sollicitudin libero, vel malesuada velit. Nullam...", date: "4.07.2020", text: ""))
     ]

    
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
    
    
    func getHeaderView(for view: MainScreenHeaderView, at section: MainScreenTypeOfSection) -> UICollectionReusableView? {
        switch section {
        case .map:
            break
            
        case .categories:
            view.categoryName.text = "Categories"
            
            return view
            
        case .blog:
            view.categoryName.text = "Blog"
            view.categoryButton.isHidden = false
            
            return view
        }
        
        return nil
    }
}

