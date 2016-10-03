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
    let log = XCGLogger.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false

    }


    @IBAction func clickLogin(_ sender: AnyObject) {
        saveAgentDataAndFetchProjects()
        self.performSegue(withIdentifier: "segueFromLoginToAllProjects", sender: self)
    }
    
    func saveAgentDataAndFetchProjects(){
        var agent: Agent
        agent = AgentDao().save(usernameTextField.text!,
                                                password: passwordTextField.text!,
                                                uri: domainTextField.text!)
        
        
        ProjectService.getAll(domain: agent.uri!,
                              username: agent.username!,
                              password: agent.password!)
            .success { (value) in
                print(">>>>>setup login view controller success")
            }
            .error { (error) in
                print("error = \(error)")
            }

    }

}
