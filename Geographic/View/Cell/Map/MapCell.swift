//
//  MapCell.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/8/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//

import UIKit
import GoogleMaps

class MapCell: UITableViewCell {
    @IBOutlet weak var mapView: GMSMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// Delegates to handle events for the location manager.
extension MapCell{
    // Handle incoming location events.
    func handleCamera(coordinate:CLLocationCoordinate2D){
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 16)
        self.mapView.camera = camera
        self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func createMarker(locationViewModel:LocationViewModel){
        let marker = GMSMarker()
        let location = LocationManager.sharedInstance.createLocation(locationViewModel: locationViewModel)
        marker.position = location
        marker.map = mapView
        marker.userData = locationViewModel
        handleCamera(coordinate: location)
    }
}

