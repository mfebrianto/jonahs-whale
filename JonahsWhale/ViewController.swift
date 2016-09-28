//
//  ViewController.swift
//  JonahsWhale
//
//  Created by michael febrianto on 21/08/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import UIKit
import CoreData
import XCGLogger

class ViewController: UIViewController {
    
    @IBOutlet var consoleText: UITextView!
    @IBOutlet var configuredAgentList: UITableView!
    
    var agents: [Agent] = []
    let log = XCGLogger.defaultInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.hidden = true
        
        configuredAgentList.delegate = self
        configuredAgentList.dataSource = self
        
        configuredAgentList.registerNib(UINib(nibName: "AvailableAgentCell", bundle: nil), forCellReuseIdentifier: "AvailableAgentCell")
        
        agents = AgentDao().getAll()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickConfigureProjects(sender: AnyObject) {
        log.debug("getting new")
        
        ProjectService.getAll()
            .success { (value) in
                self.consoleText.text = value
                self.log.debug("will change to gallery view controller")
                self.performSegueWithIdentifier("segueGalleryViewController", sender: self)
                
            }
            .error { (error) in
                print("error = \(error)")
            }
    }

    @IBAction func clickGetAllObjects(sender: AnyObject) {
        log.debug("getting existing")
        
        let projects = ProjectDao().getAll()
        
        log.debug(projects.count)
        
        for project in projects {
            log.debug(project.name)
            self.consoleText.text = self.consoleText.text + "\n" + project.name!
        }
    }
    
    @IBAction func clickMonitoredProjects(sender: AnyObject) {
        
        self.performSegueWithIdentifier("fromMainToAllProjects", sender: self)
    }
    
    

    @IBAction func clickAddRepoButton(sender: AnyObject) {
        
        self.performSegueWithIdentifier("fromMainToLogin", sender: self)
    }
   
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AvailableAgentCell",
                                                               forIndexPath: indexPath) as! AvailableAgentCell
        
        cell.setupWithModel(agents[indexPath.item])
        
        return cell
    }
    
    
}

