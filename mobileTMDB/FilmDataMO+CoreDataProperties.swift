//
//  FilmDataMO+CoreDataProperties.swift
//  
//
//  Created by rushan adelshin on 25.11.2018.
//
//

import Foundation
import CoreData


extension FilmDataMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FilmDataMO> {
        return NSFetchRequest<FilmDataMO>(entityName: "FilmData")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var vote_average: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var release_datw: String?
    @NSManaged public var overview: String?
    @NSManaged public var original_language: String?

}
