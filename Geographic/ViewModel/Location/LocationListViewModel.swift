//
//  LocationListViewModel.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/7/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//
//let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)


import Foundation
import RxSwift

protocol LocationListViewModelDelegate {
    func locationListFetchedSuccess()
    func locationListFetchedFail()
}

class LocationListViewModel {
    var delegate:LocationListViewModelDelegate!
    private var locationList = Variable<[LocationViewModel]>([])
    private var disposeBag = DisposeBag()
    
    init() {
    }
    
    func prepareData() {
        locationList.value.append(contentsOf: handleLocationsViewModel())
        if locationList.value.count > 0{
            delegate.locationListFetchedSuccess()
        }
    }
    
    func getLocationList() -> Variable<[LocationViewModel]> {
        return locationList
    }

    private func readLocations() ->  [LocationModel]{
        var locationModelList = [LocationModel]()
        
        if let path = Bundle.main.path(forResource: "DM Locations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                locationModelList = try decoder.decode([LocationModel].self, from: data)
            } catch {
                // handle error
                delegate.locationListFetchedFail()
            }
        }
        
        return locationModelList
    }
    
    private func handleLocationsViewModel() -> [LocationViewModel] {
        var locationViewModelList = [LocationViewModel]()
        let locationModelList = readLocations()
        for location in locationModelList{
            let locationViewModel = LocationViewModel(locationModel: location)
            locationViewModelList.append(locationViewModel)
        }
        
        return locationViewModelList
    }
}
