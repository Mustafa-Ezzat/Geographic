//
//  MapViewController.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/7/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker


class MapViewController: BaseViewController {
    
    @IBOutlet weak var mapView: GMSMapView!

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var markers = [GMSMarker]()
    
    var regionDictionary = [String:LocationViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        handleLocationManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// Delegates to handle events for the location manager.
extension MapViewController: CLLocationManagerDelegate, GMSMapViewDelegate{
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
        //mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func handleLocationManager(){
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50.0
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
    }
    
    func handleCamera(coordinate:CLLocationCoordinate2D){
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 12)
        self.mapView.camera = camera
        //delegate.locationUpdated()
        mapView.settings.myLocationButton = true
        self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mapView.isMyLocationEnabled = true
        self.mapView.delegate = self
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
    }
    
    func createMarker(locationViewModel:LocationViewModel){
        let marker = GMSMarker()
        let location = CLLocationCoordinate2D(latitude: Double(locationViewModel.latitude)!, longitude: Double(locationViewModel.longitude)!)
        marker.position = location
        //marker.icon = UIImage(named: AppConstant.Image.PlaceMarker)
        marker.map = mapView
        marker.userData = locationViewModel
        markers.append(marker)
    }
    
    func updateCamera(locationViewModel:LocationViewModel) {
        let location = CLLocationCoordinate2D(latitude: Double(locationViewModel.latitude)!, longitude: Double(locationViewModel.longitude)!)
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 16)
        self.mapView.camera = camera
    }
    
    // Add Region
    func addRegion(locationViewModel:LocationViewModel) {
        let location = CLLocationCoordinate2D(latitude: Double(locationViewModel.latitude)!, longitude: Double(locationViewModel.longitude)!)
        let region = CLCircularRegion(center: location, radius: 100, identifier: locationViewModel.locationID)
        locationManager.startMonitoring(for: region)
        regionDictionary[region.identifier] = locationViewModel
    }
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let locationViewModel = regionDictionary[region.identifier]{
            triggerNotification(locationViewModel: locationViewModel, welcomeMessage: Localize.WelcomeMessage.localized())
        }
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let locationViewModel = regionDictionary[region.identifier]{
            triggerNotification(locationViewModel: locationViewModel, welcomeMessage: Localize.SeeYouSoonMessage.localized())
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
    }
}
