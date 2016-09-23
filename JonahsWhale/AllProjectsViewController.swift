//
//  MonitoredProjectsViewController.swift
//  JonahsWhale
//
//  Created by michael febrianto on 22/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import UIKit
import XCGLogger

class AllProjectsViewController: UIViewController {
    
    var projects: [Project] = []
    let log = XCGLogger.defaultInstance()

    @IBOutlet var allProjectsTable: UITableView!
    
    override func viewDidLoad() {
//        log.debug("viewdidLoad")
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        allProjectsTable.dataSource = self
        allProjectsTable.delegate = self

        allProjectsTable.registerNib(UINib(nibName: "AllProjectsViewCell", bundle: nil), forCellReuseIdentifier: "AllProjectsCell")
        
//        log.debug("get all projects")
        projects = ProjectDao().getAll()
//        log.debug(projects.count)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        allProjectsTable.reloadData()
    }
    

}

extension AllProjectsViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AllProjectsCell") as! AllProjectsViewCell
        
        cell.setupWithModel(projects[indexPath.row])
        
        return cell
    }
    
}