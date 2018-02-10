//
//  LanguageManager.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/10/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//

import UIKit

class LanguageManager {
    /// get current Apple language
    static let sharedInstance: LanguageManager = {
        let instance = LanguageManager()
        // setup code
        return instance
    }()

    func currentAppleLanguage() -> String{
        let userDefaultault = UserDefaults.standard
        let languageArray = userDefaultault.object(forKey: AppConstant.App.Key.Language) as! NSArray
        let current = languageArray.firstObject as! String
        
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    
    func setAppleLAnguageTo(language: String) {
        let userDefault = UserDefaults.standard
        userDefault.set([language,currentAppleLanguage()], forKey: AppConstant.App.Key.Language)
        userDefault.synchronize()
    }
    
    func mirrorBarButtonItem(buttonItem: UIBarButtonItem) {
        if let image = buttonItem.image {
            buttonItem.image = UIImage(cgImage: image.cgImage!, scale: image.scale , orientation: .upMirrored)
        }
    }
    
    func mirrorImageView(imageView: UIImageView) {
        if let image = imageView.image {
            imageView.image = UIImage(cgImage: image.cgImage!, scale: image.scale , orientation: .upMirrored)
        }
    }
}

extension String {
    
    func localized() -> String {
        guard let bundle = Bundle.main.path(forResource: LanguageManager.sharedInstance.currentAppleLanguage(), ofType: "lproj") else {
            return NSLocalizedString(self, comment: "")
        }
        let langBundle = Bundle(path: bundle)
        return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: "")
    }
    
}

