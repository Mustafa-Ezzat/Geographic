//
//  SharedManager.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/10/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//
import UIKit
import GoogleMaps

class LocationManager{
    
    static let sharedInstance: LocationManager = {
        let instance = LocationManager()
        // setup code
        return instance
    }()
    
    func createLocation(locationViewModel:LocationViewModel) -> CLLocationCoordinate2D {
        guard let latitude = Double(locationViewModel.latitude)  else {
            return CLLocationCoordinate2D(latitude: -1, longitude: -1)
        }
        guard let longitude = Double(locationViewModel.longitude)  else {
            return CLLocationCoordinate2D(latitude: latitude, longitude: -1)
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

}
