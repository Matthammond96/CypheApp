//
//  settingViewController.swift
//  Cyphe
//
//  Created by Matthew Hammond on 28/11/2015.
//  Copyright © 2015 Matthew Hammond. All rights reserved.
//

import Foundation
import UIKit


class settingsViewController: UIViewController {
    
    @IBAction func saveButton(sender: AnyObject) {
        performSegueWithIdentifier("saveSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveSegue" {
            let saveSettings = segue.destinationViewController as! SWRevealViewController
        }
    }
}