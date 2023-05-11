//
//  Location+CoreDataProperties.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 5.05.2023.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var address: String?
    @NSManaged public var longitude: Double

}

extension Location : Identifiable {

}
