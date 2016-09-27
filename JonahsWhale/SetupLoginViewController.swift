//
//  SetupLoginViewController.swift
//  JonahsWhale
//
//  Created by michael febrianto on 26/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation


import Foundation
import UIKit
import XCGLogger

class SetupLoginViewController: UIViewController {
    
    @IBOutlet var domainTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var projects: [Project] = []
    let log = XCGLogger.defaultInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false

    }


    @IBAction func clickLogin(sender: AnyObject) {
        
        self.performSegueWithIdentifier("segueFromLoginToAllProjects", sender: self)
        
        
    }

}