//
//  MainNavigationController.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/10/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit
import Reachability
import JFMinimalNotifications

class MainNavigationController: UINavigationController {
    
    // MARK: - Properties
    
    var reach: Reachability?
    
    
    // MARK: - Navigation Controller Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listenReachability()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Reachability Methods
    
    func listenReachability() {
        self.reach = Reachability.reachabilityForInternetConnection()
        self.reach!.reachableOnWWAN = false
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.reachabilityChanged(_:)),
                                                         name: kReachabilityChangedNotification,
                                                         object: nil)
        self.reach!.startNotifier()
    }
    
    func reachabilityChanged(notification: NSNotification) {
        if self.reach!.isReachableViaWiFi() || self.reach!.isReachableViaWWAN() {
            self.showReachabilityNotification(title: "Internet Connection Available", subtitle: "The app is working now online")
        } else {
            self.showReachabilityNotification(title: "No Internet Connection", subtitle: "The app will work offline")
        }
    }
    
    func showReachabilityNotification(title title: String, subtitle: String) {
        let minimalNotification = JFMinimalNotification(style: JFMinimalNotificationStyle.Warning ,
                                                        title: title,
                                                        subTitle: subtitle, dismissalDelay: 3.0)
        minimalNotification.presentFromTop = true
        minimalNotification.edgePadding = UIEdgeInsetsMake(10, 0, 0, 0)
        let titleFont = UIFont.boldSystemFontOfSize(15)
        minimalNotification.setTitleFont(titleFont)
        let subtitleFont = UIFont.systemFontOfSize(14)
        minimalNotification.setSubTitleFont(subtitleFont)
        self.view.addSubview(minimalNotification)
        minimalNotification.show()
    }

}
