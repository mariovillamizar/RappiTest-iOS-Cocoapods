//
//  AppCollectionViewController.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/9/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit
import Reachability

class AppCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var appCollectionView: UICollectionView!
    
    
    // MARK: - Properties
    var categoryName: String!
    var reach: Reachability?
    private var appList: [App] = []
    private var collectionViewPullRefresh = UIRefreshControl()

    
    // MARK: - View Controller Lifecycle Methoda
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        self.configurePullRefreshForCollectionview()
        self.listenReachability()
        self.getAppsAndUpdateCollection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Data Source Methods
    
    func getAppsAndUpdateCollection() {
        if !self.collectionViewPullRefresh.refreshing {
            self.appCollectionView.hidden = true
        }
        let categoryName = self.categoryName.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
        iTunesClient.shared.getApps(ofCategory: categoryName, limit: 100) { (apps, error) in
            if error == nil {
                if apps != nil {
                    self.appList = apps!
                    self.appCollectionView.hidden = false
                    self.collectionViewPullRefresh.endRefreshing()
                    self.appCollectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - UICollectionView Delegate & DataSource Methods
    
    func configurePullRefreshForCollectionview() {
        self.collectionViewPullRefresh.addTarget(self, action: #selector(self.getAppsAndUpdateCollection) , forControlEvents: .ValueChanged)
        self.appCollectionView.addSubview(self.collectionViewPullRefresh)
        self.appCollectionView.alwaysBounceVertical = true
    }
    
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
        self.performSegueWithIdentifier("toAppSummary", sender: indexPath)
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
        if !self.reach!.isReachableViaWiFi() || !self.reach!.isReachableViaWWAN() {
            self.getAppsAndUpdateCollection()
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAppSummary" {
            let indexPath = sender as! NSIndexPath
            let detailsViewController = segue.destinationViewController as! AppDetailsViewController
            detailsViewController.app = self.appList[indexPath.row]
            self.appCollectionView.deselectItemAtIndexPath(indexPath, animated: true)
        }
    }

}

