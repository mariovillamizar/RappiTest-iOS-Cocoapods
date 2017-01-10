//
//  CategoryTableViewCell.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/10/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit

protocol CategoryTableViewCellDelegate: class {
    func seeSummaryOfApp(app: App)
    func seeAllAppsOfCategory(category: String)
}

class CategoryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var appsCollectionView: UICollectionView!
    
    
    // MARK: - Properties
    var categoryName: String!
    weak var delegate: CategoryTableViewCellDelegate?
    private var appList: [App] = []
    

    // MARK: - Cell Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.appsCollectionView.delegate = self
        self.appsCollectionView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cleanData()
    }
    
    func cleanData() {
        self.categoryNameLabel.text = nil
    }
    
    func setData() {
        self.categoryNameLabel.text = self.categoryName
        self.getAppsAndUpdateCollection()
    }
    
    
    // MARK: - Data Source Methods
    
    func getAppsAndUpdateCollection() {
        self.appsCollectionView.hidden = true
        let categoryName = self.categoryName.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
        iTunesClient.shared.getApps(ofCategory: categoryName, limit: 10) { (apps, error) in
            if error == nil {
                if apps != nil {
                    self.appList = apps!
                    self.appsCollectionView.hidden = false
                    self.appsCollectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - UICollectionView Delegate & DataSource Methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appList.count > 10 ? 10 : self.appList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("appCollectionCell", forIndexPath: indexPath) as! AppCollectionViewCell
        cell.app = self.appList[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        (cell as! AppCollectionViewCell).setData()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.seeSummaryOfApp(self.appList[indexPath.row])
    }
    
    // MARK: Outlets Actions
    
    @IBAction func seeAllAppsButtonAction(sender: AnyObject) {
        self.delegate?.seeAllAppsOfCategory(self.categoryName)
    }
    

}
