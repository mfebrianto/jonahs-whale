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
    
    let log = XCGLogger.default
    
    var agents: [Agent] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        
        configuredAgentList.delegate = self
        configuredAgentList.dataSource = self
        
        configuredAgentList.register(UINib(nibName: "AvailableAgentCell", bundle: nil), forCellReuseIdentifier: "AvailableAgentCell")
        
        agents = AgentDao().getAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickConfigureProjects(_ sender: AnyObject) {
        log.debug("getting new")
        
        ProjectService.getAll()
            .success { (value) in
//                self.consoleText.text = value
                self.log.debug("will change to gallery view controller")
//                self.performSegue(withIdentifier: "segueGalleryViewController", sender: self)
                
            }
            .error { (error) in
                print("error = \(error)")
            }
    }

    @IBAction func clickGetAllObjects(_ sender: AnyObject) {
        log.debug("getting existing")
        
        let projects = ProjectDao().getAll()
        
        log.debug(projects.count)
        
        for project in projects {
            log.debug(project.name)
            self.consoleText.text = self.consoleText.text + "\n" + project.name!
        }
    }
    
    @IBAction func clickMonitoredProjects(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "fromMainToAllProjects", sender: self)
    }
    
    

    @IBAction func clickAddRepoButton(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "fromMainToLogin", sender: self)
    }
   
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = configuredAgentList.dequeueReusableCell(withIdentifier: "AvailableAgentCell",
                                                               for: indexPath) as! AvailableAgentCell
        
        cell.setupWithModel(agents[(indexPath as NSIndexPath).item])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "segueGalleryViewController", sender: self)
        
    }

    
}

