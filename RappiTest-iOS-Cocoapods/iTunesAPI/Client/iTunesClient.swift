//
//  iTunesClient.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/9/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class iTunesClient: NSObject {
    
    static let shared = iTunesClient()

    let iTunesBaseURL = "https://itunes.apple.com/us/rss/"
    
    // MARK: - Queries
    
    func getApps(ofCategory category: String, limit: Int, completionHandler: (apps: [App]?, error: NSError?) -> Void) {
        
        let endPoint = String(format: "%@/limit=%d/json", category, limit)
        let url = iTunesBaseURL + endPoint
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let JSON = (response.result.value as? [String: AnyObject])!["feed"]!["entry"] {
                    let applications = Mapper<App>().mapArray(JSON)
                    completionHandler(apps: applications, error: nil)
                }
            case .Failure(let error):
                completionHandler(apps: nil, error: error)
            }
        }
    }
}
