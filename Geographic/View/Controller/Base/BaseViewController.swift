//
//  BaseViewController.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/7/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI //framework to customize the notification

class BaseViewController: UIViewController {
    
    let requestIdentifier = "LocationRequest" //identifier is to cancel the notification request
    @IBOutlet weak var languageItem: UIBarButtonItem!
    @IBOutlet weak var backItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        handleNavBar()
       
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
    
    @IBAction func backAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func backActionWithoutAnimation(_ sender: Any) {
        _ = navigationController?.popViewController(animated: false)
    }
    func handleNavBar() {
        if let font = UIFont(name: AppConstant.Font.Family.Dubai.Regular, size: 22){
            self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor:getColor(with: AppConstant.Color.NavBar), NSAttributedStringKey.font: font]
            
            self.languageItem?.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
            
            if backItem != nil{
                if LanguageManager.sharedInstance.currentAppleLanguage() == Language.AR {
                    LanguageManager.sharedInstance.mirrorBarButtonItem(buttonItem: backItem)
                }
            }
        }
    }
    func getColor(with hexString:String) -> UIColor {
        return UIColor(hexString: hexString)
    }
    
    @IBAction func switchLanguage(_ sender: Any) {
        alert(message: Localize.RestartMessageBody.localized(), title: Localize.RestartMessageTitle.localized())
    }
    
    func restartApp() {
         if LanguageManager.sharedInstance.currentAppleLanguage() == Language.EN {
            LanguageManager.sharedInstance.setAppleLAnguageTo(language: Language.AR)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
         } else {
            LanguageManager.sharedInstance.setAppleLAnguageTo(language: Language.EN)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
         }
        exit(0)
    }

    func callPhone(phoneText:String) {
        guard let number = URL(string: "tel://" + phoneText) else {
            return
        }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(number)
        } else {
            UIApplication.shared.openURL(number)
        }
    }
    
    func triggerNotification(locationViewModel:LocationViewModel, welcomeMessage:String){
        let content = UNMutableNotificationContent()
        if LanguageManager.sharedInstance.currentAppleLanguage() == Language.AR{
            content.title = locationViewModel.country_ar
            content.subtitle = locationViewModel.city_ar
            content.body = welcomeMessage + locationViewModel.name_ar
        } else{
            content.title = locationViewModel.country
            content.subtitle = locationViewModel.city
            content.body = welcomeMessage + locationViewModel.name
        }
        content.sound = UNNotificationSound.default()
        
        //To Present image in notification
        if let path = Bundle.main.path(forResource: "dubai-muncipalty", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            do {
                let attachment = try UNNotificationAttachment(identifier: "sampleImage", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("attachment not found.")
            }
        }
        
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest(identifier:requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request){(error) in
            
            if (error != nil){
                print("error: ", error?.localizedDescription ?? "")
            }
        }
    }
    
    func stopNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [requestIdentifier])
    }

}

extension BaseViewController:UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier == requestIdentifier{
            completionHandler( [.alert,.sound,.badge])
        }
    }
}

extension BaseViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: Localize.RestartYes.localized(), style: .default, handler: {(alert:UIAlertAction!)
            in
            self.restartApp()
        })
        
        let CancelAction = UIAlertAction(title: Localize.RestartNo.localized(), style: .default, handler: nil)
        
        alertController.addAction(OKAction)
        alertController.addAction(CancelAction)
        
        alertController.view.tintColor = getColor(with: AppConstant.Color.NavBar)
        self.present(alertController, animated: true, completion: nil)
    }
}

