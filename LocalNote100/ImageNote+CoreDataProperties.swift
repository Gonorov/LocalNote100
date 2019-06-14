//
//  ImageNote+CoreDataProperties.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 02/06/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageNote> {
        return NSFetchRequest<ImageNote>(entityName: "ImageNote")
    }

    @NSManaged public var imageBig: NSData?
    @NSManaged public var note: Note?

}
