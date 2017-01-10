//
//  AppDetailsViewController.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/9/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import UIKit

class AppDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    
    // MARK: - Properties
    
    var app: App!
    
    
    // MARK: - View Controller Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailsTableView.rowHeight = UITableViewAutomaticDimension
        self.detailsTableView.estimatedRowHeight = 140
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableView Delegate & DataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if self.app.summary != nil { numberOfRows += 1 }
        if self.app.rights != nil { numberOfRows += 1 }
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as! BasicTableViewCell
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = self.app.summary == nil ? self.app.rights : self.app.summary 
        case 1:
            cell.titleLabel.text = self.app.rights
        default:
            cell.titleLabel.text = nil
        }
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = self.detailsTableView.dequeueReusableCellWithIdentifier("headerCell") as! AppTableViewCell
        headerCell.app = self.app
        return headerCell
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! AppTableViewCell).setData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
