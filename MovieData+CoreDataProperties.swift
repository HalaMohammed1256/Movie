//
//  MovieData+CoreDataProperties.swift
//  
//
//  Created by Hala on 14/03/2021.
//
//

import Foundation
import CoreData


extension MovieData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        return NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    @NSManaged public var movieGenra: [String]?
    @NSManaged public var movieImage: String?
    @NSManaged public var movieImgeData: Data?
    @NSManaged public var movieRate: Double
    @NSManaged public var movieRelease: Int32
    @NSManaged public var movieTitle: String?

}
