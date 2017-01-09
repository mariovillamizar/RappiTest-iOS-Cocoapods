//
//  UINavigationController+Extension.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/9/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if let visibleViewController = visibleViewController {
            return visibleViewController.supportedInterfaceOrientations()
        }
        return .Portrait
    }
    
    public override func shouldAutorotate() -> Bool {
        if let visibleViewController = visibleViewController {
            return visibleViewController.shouldAutorotate()
        }
        return true
    }
    
    var previousViewController: UIViewController? {
        let stack = self.viewControllers
        if stack.count > 1 {
            return stack[stack.count - 2]
        }
        return nil
    }
}
