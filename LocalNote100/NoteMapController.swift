//
//  NoteMapController.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 05/07/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//

import UIKit
import MapKit

class NoteAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var note: Note
    var title: String?
    var subtitle: String?
   
    
    init(note: Note){
        self.note = note
        title = note.name
        if note.locationActual != nil {
       coordinate = CLLocationCoordinate2D(latitude: note.locationActual!.lat, longitude: note.locationActual!.lon)
        } else {
         coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    
    
}


class NoteMapController: UIViewController {
    
    var note: Note?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        if note?.locationActual != nil {
      
        mapView.addAnnotation(NoteAnnotation(note: note!))
        mapView.centerCoordinate = CLLocationCoordinate2D (latitude: note!.locationActual!.lat, longitude: note!.locationActual!.lon)
            
        }
        
        let ltgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
        mapView.gestureRecognizers = [ltgr]
        
    }
    
    @objc func handleLongTap(recongnizer: UIGestureRecognizer) {
        if recongnizer.state != .began {
            return
        }
        
        let point = recongnizer.location(in: mapView)
        let c = mapView.convert(point, toCoordinateFrom: mapView)
        note?.locationActual = LocationCoordinate(lat: c.latitude, lon: c.longitude)
        CoreDataManager.sharedInstance.saveContext()
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(NoteAnnotation(note: note!))
    }

}
extension NoteMapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.animatesDrop = true
        pin.isDraggable = true
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if newState == .ending {
            let newLocation = LocationCoordinate(lat: (view.annotation?.coordinate.latitude)!, lon: (view.annotation?.coordinate.longitude)!)
            note?.locationActual = newLocation
            CoreDataManager.sharedInstance.saveContext()
        }
       
    }
}

