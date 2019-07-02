//
//  Location+CoreDataProperties.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 02/06/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var lon: Double
    @NSManaged public var lat: Double
    @NSManaged public var note: Note?

}
