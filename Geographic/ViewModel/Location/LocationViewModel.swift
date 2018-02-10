//
//  LocationViewModel.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/7/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//

class LocationViewModel {

    var locationModel:LocationModel?
    
    var locationID: String {
        guard let locationID = locationModel?.locationID else {
            return ""
        }
        return locationID
    }

    var name: String {
        guard let name = locationModel?.name else {
            return ""
        }
        return name
    }

    var name_ar: String {
        guard let name_ar = locationModel?.name_ar else {
            return ""
        }
        return name_ar
    }

    var city: String {
        guard let city = locationModel?.city else {
            return ""
        }
        return city
    }
    
    var city_ar: String {
        guard let city_ar = locationModel?.city_ar else {
            return ""
        }
        return city_ar
    }

    var country: String {
        guard let country = locationModel?.country else {
            return ""
        }
        return country
    }

    var country_ar: String {
        guard let country_ar = locationModel?.country_ar else {
            return ""
        }
        return country_ar
    }

    var email: String {
        guard let email = locationModel?.email else {
            return ""
        }
        return email
    }
    
    var phone: String {
        guard let phone = locationModel?.phone else {
            return ""
        }
        return phone
    }

    var phone_ar: String {
        guard let phone_ar = locationModel?.phone_ar else {
            return ""
        }
        return phone_ar
    }

    var latitude: String {
        guard let latitude = locationModel?.latitude else {
            return ""
        }
        return latitude
    }

    var longitude: String {
        guard let longitude = locationModel?.longitude else {
            return ""
        }
        return longitude
    }

    var type: String {
        guard let type = locationModel?.type else {
            return ""
        }
        return type
    }
    
    var type_ar: String {
        guard let type_ar = locationModel?.type_ar else {
            return ""
        }
        return type_ar
    }


    var url: String {
        guard let url = locationModel?.url else {
            return ""
        }
        return url
    }

    init(locationModel:LocationModel){
        self.locationModel = locationModel
    }
    
}
