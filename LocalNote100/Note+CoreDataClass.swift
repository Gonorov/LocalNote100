//
//  Note+CoreDataClass.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 02/06/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Note)
public class Note: NSManagedObject {
    class func newNote(name: String) -> Note {
        let newNote = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        newNote.name = name
        newNote.dateUpdate = NSDate()
        
        return newNote
    }
    
    func addImage (image: UIImage) {
        let imageNote = ImageNote (context: CoreDataManager.sharedInstance.managedObjectContext)
        
        imageNote.imageBig = image.jpegData(compressionQuality: 1.0) as NSData?

       // imageNote.imageBig = UIImageJPEGRepresentation(image, 1) as NSData?
        
        self.image = imageNote
    }
    
    func addLocation(latitude: Double, lontitude: Double){
        
        let location = Location (context: CoreDataManager.sharedInstance.managedObjectContext)
        location.lat = latitude
        location.lon = lontitude
        
        self.location = location
        
    }
}
