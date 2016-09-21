//
//  ProjectController.swift
//  JonahsWhale
//
//  Created by michael febrianto on 19/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import XCGLogger
import CoreData


class ProjectDao {
    
    let entityName = "Project"
    let log = XCGLogger.defaultInstance()

    
    func deleteAll() {
    
//        dataContext.projects.filter({ $0.id != nil }).delete()
        
    }
    
    func getAll() -> [Project] {
        
        var projects:[Project] = []
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            projects = results as! [Project]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return projects
    }
}