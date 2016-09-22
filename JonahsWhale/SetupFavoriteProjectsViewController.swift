//
//  SetupFavoriteProjectsViewController.swift
//  JonahsWhale
//
//  Created by michael febrianto on 22/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation

import UIKit
import CoreData
import XCGLogger

class SetupFavoriteProjectsViewController: UIViewController {

    let log = XCGLogger.defaultInstance()
    
    @IBAction func clickBackButton(sender: AnyObject) {
        
        log.debug("back button clicked")
        
        self.performSegueWithIdentifier("ViewControllerFrfavProjs", sender: self)
        
    }
}