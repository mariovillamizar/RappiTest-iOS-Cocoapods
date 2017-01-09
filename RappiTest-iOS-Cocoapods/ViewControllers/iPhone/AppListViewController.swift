//
//  AppListViewController.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/9/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit

class AppListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var appsTableView: UITableView!
    
    
    // MARK: - Properties
    private var appList: [App] = []
    
    
    // MARK: - View Controller Lifecycle Methoda
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAppsAndUpdateTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Data Source Methods
    
    func getAppsAndUpdateTableView() {
        iTunesClient.shared.getFreeApplications { (apps, error) in
            if error == nil {
                if apps != nil {
                    self.appList = apps!
                    self.appsTableView.reloadData()
                }
            }
        }
    }
    
    // MARK: UITableView Delegate & DataSource Methods
    
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
}
