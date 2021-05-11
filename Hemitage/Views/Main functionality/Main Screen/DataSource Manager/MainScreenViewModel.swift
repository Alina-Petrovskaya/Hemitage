//
//  DatasourceManagerMainScreenProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import UIKit

protocol MainScreenModelViewProtocol {
    
    func getSectionContent(for sectionType: MainScreenTypeOfSection) -> [MainScreenModel]
    func getHeaderView(for view: MainScreenHeaderView, at section: MainScreenTypeOfSection) -> UICollectionReusableView?
}

class MainScreenViewModel: MainScreenModelViewProtocol {
    
    private var mapData: [MainScreenModel] = [MainScreenModel.map(MapModel(allUsers: 15, usersOnline: 5))]
    
    private var categoriesdata: [MainScreenModel] = [
        MainScreenModel.category(CategoriesModel(imageName: "Meditation", name: "Meditation")),
        MainScreenModel.category(CategoriesModel(imageName: "Sleep", name: "Sleep")),
        MainScreenModel.category(CategoriesModel(imageName: "forest", name: "Mid-Day Relaxation"))
    ]
    
     private var blogData: [MainScreenModel] = [
        MainScreenModel.blog(BlogModel(imageName:  "river", title: "One", preview: "Praesent eu dolor eu orci vehicula euismod. Vivamus sed sollicitudin libero, vel malesuada velit. Nullam...", date: "11.12.2020", text: "")) ,
        MainScreenModel.blog(BlogModel(imageName:  "", title: "Two", preview: "Praesent eu dolor eu orci vehicula euismod. Vivamus sed sollicitudin libero, vel malesuada velit. Nullam...", date: "10.12.2020", text: "")),
        MainScreenModel.blog(BlogModel(imageName:  "forest", title: "Etiam vivamus", preview: "Praesent eu dolor eu orci vehicula euismod. Vivamus sed sollicitudin libero, vel malesuada velit. Nullam...", date: "4.07.2020", text: ""))
     ]

    
    func getSectionContent(for sectionType: MainScreenTypeOfSection) -> [MainScreenModel] {
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

