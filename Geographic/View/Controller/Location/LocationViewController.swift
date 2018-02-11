//
//  LocationViewController.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/7/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMaps

enum ShowOption{
    case List
    case Map
}

class LocationViewController: MapViewController {

    let locationListViewModel = LocationListViewModel()
    var disposeBag = DisposeBag()
    
    var locationViewModel:LocationViewModel?

    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var toggleItem: UIBarButtonItem!
    
    var showOption:ShowOption = .List

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareBindingData()
        handleMap()
        locationTableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg.png"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == AppConstant.Segue.PlaceDetails{
            let vc = segue.destination as! PlaceDetailsViewController
            vc.locationViewModel = self.locationViewModel
        }
    }
    
    @IBAction func toggleAction(_ sender: Any) {
        if showOption == .List{
            toggle(hideMap: false, hideList: true)
            showOption = .Map
            toggleItem.image = UIImage.init(named: AppConstant.Image.List)
        } else{
            toggle(hideMap: true, hideList: false)
            showOption = .List
            toggleItem.image = UIImage.init(named: AppConstant.Image.Map)
        }
    }
    
    func toggle(hideMap:Bool, hideList:Bool) {
        mapView.isHidden = hideMap
        locationTableView.isHidden = hideList
    }
    
    func handleMap() {
        for location in locationListViewModel.getLocationList().value {
            createMarker(locationViewModel: location)
            addRegion(locationViewModel: location)
        }
        fitBound()
    }
    
    func prepareBindingData() {
        locationTableView.register(UINib(nibName: AppConstant.Cell.Location, bundle: nil), forCellReuseIdentifier: AppConstant.Cell.Location)
        populateListTableView()
        setupCellWhenTapped()
    }
    
    // MARK: - perform a binding from observableCity from ViewModel to TableView
    private func populateListTableView() {
        let observableTodos = locationListViewModel.getLocationList().asObservable()
        observableTodos.bind(to: locationTableView.rx.items(cellIdentifier: AppConstant.Cell.Location, cellType: LocationCell.self)){  (row, element, cell) in
            cell.configure(with: element)
            cell.delegate = self
            }
            .addDisposableTo(disposeBag)
    }
    // MARK: - subscribe to TableView when item has been selected
    private func setupCellWhenTapped() {
        locationTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                //code here
                self.locationViewModel = self.locationListViewModel.getLocationList().value[indexPath.row]
                self.performSegue(withIdentifier: AppConstant.Segue.PlaceDetails, sender: self)
            })
            .addDisposableTo(disposeBag)
    }
    
}

extension LocationViewController: LocationCellDelegate{
    func call(phoneNumber: String) {
        callPhone(phoneText: phoneNumber)
        print("Phone: ", phoneNumber)
    }
}

extension LocationViewController{
    // MARK: CLLocationManagerDelegate, GMSMapViewDelegate
    override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        super.locationManager(manager, didUpdateLocations: locations)
        let location: CLLocation = locations.last!
        handleCamera(coordinate: location.coordinate)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        locationViewModel = marker.userData as? LocationViewModel
        performSegue(withIdentifier: AppConstant.Segue.PlaceDetails, sender: self)
        return true
    }
    
    func fitBound() {
        var bounds = GMSCoordinateBounds()
        for marker in markers
        {
            bounds = bounds.includingCoordinate(marker.position)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
        mapView.animate(with: update)
    }
}

