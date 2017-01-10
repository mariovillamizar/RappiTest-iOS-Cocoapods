//
//  CategoriesViewController.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/10/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CategoryTableViewCellDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var categoriesTableView: UITableView!

    
    // MARK: - Properties
    
    let categories = ["Top Free Applications", "Top Grossing Applications", "Top Paid Applications", "New Free Applications", "New Paid Applications"]
    
    
    // MARK: - View Controller Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - UITableView Delegate & DataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryTableViewCell
        cell.categoryName = self.categories[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! CategoryTableViewCell).setData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    // MARK: - CategoryCollectionViewCell Delegate Methods
    
    func seeSummaryOfApp(app: App) {
        self.performSegueWithIdentifier("toAppSummary", sender: app)
    }
    
    func seeAllAppsOfCategory(category: String) {
        self.performSegueWithIdentifier("toAppsList", sender: category)
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAppSummary" {
            
            let appSummaryViewController = segue.destinationViewController as! AppDetailsViewController
            appSummaryViewController.app = sender as! App
            
        } else if segue.identifier == "toAppsList" {            
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                let appCollectionViewController = segue.destinationViewController as! AppCollectionViewController
                appCollectionViewController.categoryName = sender as! String
            } else {
                let appListViewController = segue.destinationViewController as! AppListViewController
                appListViewController.categoryName = sender as! String
            }
        }
    }
    

}
