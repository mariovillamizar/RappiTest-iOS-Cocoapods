//
//  AppCollectionViewController.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/9/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit

class AppCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var appCollectionView: UICollectionView!
    
    
    // MARK: - Properties
    private var appList: [App] = []
    
    
    // MARK: - View Controller Lifecycle Methoda
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAppsAndUpdateCollection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Data Source Methods
    
    func getAppsAndUpdateCollection() {
        iTunesClient.shared.getFreeApplications { (apps, error) in
            if error == nil {
                if apps != nil {
                    self.appList = apps!
                    self.appCollectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - UICollectionView Delegate & DataSource Methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appList.count
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
        self.performSegueWithIdentifier("toAppDetails", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAppDetails" {
            let indexPath = sender as! NSIndexPath
            let detailsViewController = segue.destinationViewController as! AppDetailsViewController
            detailsViewController.app = self.appList[indexPath.row]
            self.appCollectionView.deselectItemAtIndexPath(indexPath, animated: true)
        }
    }

}

