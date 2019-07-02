//
//  LocationManager.swift
//  LocalNote100
//
//  Created by Oleksandr Gonorovskyy on 02/07/2019.
//  Copyright © 2019 Oleksandr Gonorovskyy. All rights reserved.
//

import UIKit

import CoreLocation
struct LocationCoordinate {
    var lat: Double
    var lon: Double
    
    static func create(location: CLLocation) -> LocationCoordinate {
        return LocationCoordinate (lat: location.coordinate.latitude, lon: location.coordinate.longitude)
    }
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shareInstance = LocationManager()
    var manager = CLLocationManager()
    
    func requestAutorrization() {
      
        manager.requestWhenInUseAuthorization()
    }
    var blockForSave: ((LocationCoordinate) -> Void)?
    func getCurrentLocation(block: ((LocationCoordinate) -> Void)?) {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            print("Пользователь не дал доступа к локации")
            return
        }
        
        blockForSave = block
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.activityType = .other
    manager.startUpdatingLocation()
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lc = LocationCoordinate.create(location: locations.last!)
        blockForSave?(lc)
        manager.stopUpdatingLocation()
    }
}
