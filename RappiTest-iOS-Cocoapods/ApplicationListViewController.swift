//
//  ViewController.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/9/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit

class ApplicationListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iTunesClient.shared.getFreeApplications { (applications, error) in
            if error == nil {
                if applications != nil {
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

