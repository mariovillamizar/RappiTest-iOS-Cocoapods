//
//  AppCollectionViewCell.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/9/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit
import SDWebImage

class AppCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appCompanyLabel: UILabel!
    
    // MARK: Properties
    
    var app: App!
    
    
    // MARK: Cell Lifecycle Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cleanData()
    }
    
    func cleanData() {
        self.appIconImageView.image = nil
        self.appNameLabel.text = nil
        self.appCompanyLabel.text = nil
    }
    
    func setData() {
        self.appNameLabel.text = self.app.name
        self.appCompanyLabel.text = self.app.artist
        let url = NSURL(string: (self.app.images?.last?.label)!)
        self.appIconImageView.sd_setImageWithURL(url) { (_, error, _, _) in
            if error != nil {
                
            }
        }
    }
}
