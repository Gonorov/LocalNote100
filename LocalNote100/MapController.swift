//
//  MapController.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 12/07/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {
 @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        let ltgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
        mapView.gestureRecognizers = [ltgr]
        
    }
    
    @objc func handleLongTap(recongnizer: UIGestureRecognizer) {
        if recongnizer.state != .began {
            return
        }
        
        let point = recongnizer.location(in: mapView)
        let c = mapView.convert(point, toCoordinateFrom: mapView)
        let newNote = Note.newNote(name: "New note".localize(), inFolder: nil)
        newNote.locationActual = LocationCoordinate(lat: c.latitude, lon: c.longitude)
        
        let noteController = storyboard?.instantiateViewController(withIdentifier: "noteSID") as! NoteController
        noteController.note = newNote
        navigationController?.pushViewController(noteController, animated: true)
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        mapView.removeAnnotations(mapView.annotations)
        
        for note in notes {
            if note.locationActual != nil {
                mapView.addAnnotation(NoteAnnotation(note: note))
            }
        }
    }
}



    extension MapController: MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation {
                DispatchQueue.main.async {
                    mapView.setCenter(annotation.coordinate, animated: true)
                }
                
                return nil
            }
            
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.animatesDrop = true
            pin.canShowCallout = true
            
            pin.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
            
            return pin
        }
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
            let selectedNote = (view.annotation as! NoteAnnotation).note
            let noteController = storyboard?.instantiateViewController(withIdentifier: "noteSID") as! NoteController
            noteController.note = selectedNote
            navigationController?.pushViewController(noteController, animated: true)
        
        }
        
}
