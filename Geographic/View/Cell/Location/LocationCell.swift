//
//  LocationCell.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/7/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//

import UIKit

protocol LocationCellDelegate {
    func call(phoneNumber:String)
}

class LocationCell: MapCell {
    
    var delegate:LocationCellDelegate!
    var locationViewModel:LocationViewModel?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var phoneImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with locationViewModel:LocationViewModel) {
        
        self.locationViewModel = locationViewModel
        
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 2
        
        createMarker(locationViewModel: locationViewModel)
        
        if LanguageManager.sharedInstance.currentAppleLanguage() == Language.AR{
            handleIcon(theImageView: countryImageView)
            handleIcon(theImageView: cityImageView)
            handleIcon(theImageView: phoneImageView)
            
            nameLabel.text = locationViewModel.name_ar
            countryLabel.text = locationViewModel.country_ar
            cityLabel.text = locationViewModel.city_ar
            phoneLabel.text = locationViewModel.phone_ar
        } else{
            nameLabel.text = locationViewModel.name
            countryLabel.text = locationViewModel.country
            cityLabel.text = locationViewModel.city
            phoneLabel.text = locationViewModel.phone
        }
        
        tintIcon(theImageView: countryImageView)
        tintIcon(theImageView: cityImageView)
        tintIcon(theImageView: phoneImageView)
    }
    
    func takeMapSnapshot() {
        let Width = 100
        let Height = 200
        
        let mapImageUrl = "https://maps.googleapis.com/maps/api/staticmap?center="
        let latlong = "18.495651759752, 73.809987567365"
        
        let mapUrl  = mapImageUrl + latlong
        
        let size = "&size=" +  "\(Int(Width))" + "x" +  "\(Int(Height))"
        let positionOnMap = "&markers=size:mid|color:red|" + latlong
        let staticImageUrl = mapUrl + size + positionOnMap
    }
    
    func handleIcon(theImageView:UIImageView){
        LanguageManager.sharedInstance.mirrorImageView(imageView: theImageView)
    }

    func tintIcon(theImageView:UIImageView){
        theImageView.image = theImageView.image!.withRenderingMode(.alwaysTemplate)
        theImageView.tintColor = getColor(with: AppConstant.Color.TintIcon)
    }

    func getColor(with hexString:String) -> UIColor {
        return UIColor(hexString: hexString)
    }

    @IBAction func callAction(_ sender: Any) {
        delegate.call(phoneNumber: (self.locationViewModel?.phone)!)
    }
}
