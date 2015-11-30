//
//  menuTableViewController.swift
//  Cyphe
//
//  Created by Matthew Hammond on 27/11/2015.
//  Copyright © 2015 Matthew Hammond. All rights reserved.
//

import Foundation
import UIKit

class menuTableViewController: UITableViewController {
    
    @IBOutlet var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logoutSegue" {
            let loginVC = segue.destinationViewController as! loginScreenViewController
        }
        if segue.identifier == "settingSegue" {
            let settingsVC = segue.destinationViewController as! settingsViewController
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
        if row == 5 {
            performSegueWithIdentifier("settingSegue", sender: self)
        }
        if row == 6 {
            performSegueWithIdentifier("logoutSegue", sender: self)
        }

    }
}
