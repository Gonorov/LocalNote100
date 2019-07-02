//
//  Folder+CoreDataProperties.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 02/06/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var name: String?
    @NSManaged public var dateUpdate: NSDate?
    @NSManaged public var image: NSData?
    @NSManaged public var notes: NSSet?

}

// MARK: Generated accessors for notes
extension Folder {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}
