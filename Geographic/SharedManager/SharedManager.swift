//
//  SharedManager.swift
//  Geographic
//
//  Created by Mustafa Ezzat on 2/10/18.
//  Copyright © 2018 Mustafa Ezzat. All rights reserved.
//
import UIKit

class SharedManager{
    
    static let sharedInstance: SharedManager = {
        let instance = SharedManager()
        // setup code
        return instance
    }()
    
}
