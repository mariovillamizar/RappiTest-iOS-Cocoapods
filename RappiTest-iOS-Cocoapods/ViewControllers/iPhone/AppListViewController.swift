//
//  AppListViewController.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/9/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit
import Reachability

class AppListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var appsTableView: UITableView!
    
    
    // MARK: - Properties
    var categoryName: String!
    var reach: Reachability?
    private var appList: [App] = []
    private var tableViewPullRefresh = UIRefreshControl()
    
    // MARK: - View Controller Lifecycle Methoda
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        self.configurePullRefreshForTableView()
        self.listenReachability()
        self.getAppsAndUpdateTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Data Source Methods
    
    func getAppsAndUpdateTableView() {
        if !self.tableViewPullRefresh.refreshing {
            self.appsTableView.hidden = true
        }
        let categoryName = self.categoryName.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
        iTunesClient.shared.getApps(ofCategory: categoryName, limit: 100) { (apps, error) in
            if error == nil {
                if apps != nil {
                    self.appList = apps!
                    self.appsTableView.hidden = false
                    self.tableViewPullRefresh.endRefreshing()
                    self.appsTableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - UITableView Delegate & DataSource Methods
    
    func configurePullRefreshForTableView() {
        self.tableViewPullRefresh.addTarget(self, action: #selector(self.getAppsAndUpdateTableView) , forControlEvents: .ValueChanged)
        self.appsTableView.addSubview(self.tableViewPullRefresh)
        self.appsTableView.alwaysBounceVertical = true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.appsTableView.dequeueReusableCellWithIdentifier("appListCell", forIndexPath: indexPath) as! AppTableViewCell
        cell.app = self.appList[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! AppTableViewCell).setData()
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
            self.getAppsAndUpdateTableView()
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAppSummary" {
            let indexPath = sender as! NSIndexPath
            let detailsViewController = segue.destinationViewController as! AppDetailsViewController
            detailsViewController.app = self.appList[indexPath.row]
            self.appsTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
}
