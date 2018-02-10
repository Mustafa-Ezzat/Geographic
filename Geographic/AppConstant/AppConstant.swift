//
//  AppConstant.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/7/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//


enum AppConstant {
    enum Color {
        static let NavBar = "#50AD54"
        static let TintIcon = "#50AD54"
    }
    enum Cell {
        static let Location = "LocationCell"
    }
    enum Image {
        static let Map = "Map"
        static let List = "List"
        static let CurrentMarker = "currentMarker.png"
        static let PlaceMarker = "placeMarker.png"
    }
    enum APIKey{
        static let Google = "AIzaSyCmn4Ky2OXAXvhKF6KcX4-N-vb75PI31ME"
    }
    
    enum Segue{
        static let PlaceDetails = "placeDetailsSegue"
        static let Web = "webSegue"
        static let List = "listSegue"        
    }
    enum ViewController {
        static let Location = "LocationViewController"
    }
    enum NavController {
        static let Root = "RootNavController"
    }
    enum App {
        enum Key {
            static let Language = "AppleLanguages"
        }
    }
    enum Font {
        enum Family {
            enum Dubai{
                static let Regular = "Dubai-Regular"
            }
        }
    }
}
