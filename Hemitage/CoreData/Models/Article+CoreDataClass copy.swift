//
//  Article+CoreDataClass.swift
//  
//
//  Created by Alina Petrovskaya on 19.05.2021.
//
//

import Foundation
import CoreData


public class Article: NSManagedObject {

}

extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var previewImageName: String?
    @NSManaged public var id: String?
    @NSManaged public var date: Date
}
