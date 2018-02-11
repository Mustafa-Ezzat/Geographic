//
//  PlaceDetailsViewController.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/7/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//

import UIKit
import MessageUI

class PlaceDetailsViewController: MapViewController {

    var locationViewModel:LocationViewModel?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var cityIcon: UIImageView!
    @IBOutlet weak var countryIcon: UIImageView!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var rightArrowIcon: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg.png"))

        if let location = locationViewModel{
            createMarker(locationViewModel: location)
            updateCamera(locationViewModel: location)
            
            emailLabel.text = location.email
            urlLabel.text = location.url
            
            if LanguageManager.sharedInstance.currentAppleLanguage() == Language.AR{
                nameLabel.text = location.name_ar
                countryLabel.text = location.country_ar
                cityLabel.text = location.city_ar
                phoneLabel.text = location.phone_ar
                typeLabel.text = location.type_ar

                handleIcon(theImageView: cityIcon)
                handleIcon(theImageView: countryIcon)
                handleIcon(theImageView: phoneIcon)
                handleIcon(theImageView: emailIcon)
                handleIcon(theImageView: rightArrowIcon)
            } else{
                nameLabel.text = location.name
                countryLabel.text = location.country
                cityLabel.text = location.city
                phoneLabel.text = location.phone
                typeLabel.text = location.type
            }

        }
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
        if segue.identifier == AppConstant.Segue.Web{
            let vc = segue.destination as! WebViewController
            vc.url = self.urlLabel.text!
        }
    }
    
    func handleIcon(theImageView: UIImageView) {
        LanguageManager.sharedInstance.mirrorImageView(imageView: theImageView)
    }
    
    @IBAction func openGoogleAction(_ sender: Any) {
        let destination = "\((locationViewModel?.latitude)!),\((locationViewModel?.longitude)!)"
        openGoogleMap(destination: destination)
    }
    
    
    @IBAction func openUrlAction(_ sender: Any) {
        performSegue(withIdentifier: AppConstant.Segue.Web, sender: self)
    }
    
    @IBAction func sendEmailAction(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([emailLabel.text!])
            mail.setMessageBody("", isHTML: true)
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    @IBAction func callPhoneAction(_ sender: Any) {
        callPhone(phoneText: (locationViewModel?.phone)!)
    }
    
}

extension PlaceDetailsViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
