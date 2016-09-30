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
    let log = XCGLogger.default

    @IBOutlet var allProjectsTable: UITableView!
    
    override func viewDidLoad() {
        log.debug("viewdidLoad")
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        allProjectsTable.dataSource = self
        allProjectsTable.delegate = self

        allProjectsTable.register(UINib(nibName: "AllProjectsViewCell", bundle: nil), forCellReuseIdentifier: "AllProjectsCell")
        
//        log.debug("get all projects")
        projects = ProjectDao().getAll()
//        log.debug(projects.count)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        allProjectsTable.reloadData()
    }
    

}

extension AllProjectsViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllProjectsCell") as! AllProjectsViewCell
        
        cell.setupWithModel(projects[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
}
