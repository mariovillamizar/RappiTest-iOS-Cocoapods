//
//  GlobalAppearance.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/10/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit

class GlobalAppearance: NSObject {
    
    func applyGlobalAppearance() {
        self.customizeNavigationBar()
    }
    
    func customizeNavigationBar() {
        UINavigationBar.appearance().translucent = true
        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
}
