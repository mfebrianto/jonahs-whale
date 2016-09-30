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
//    let log = XCGLogger.defaultInstance()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveAll(_ projectXmls: [ProjectXml]) {
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entity(forEntityName: entityName, in:managedContext)
        
            for projectXml in projectXmls {
                let project = NSManagedObject(entity: entity!,
                                        insertInto:managedContext)
        
//                log.debug("trying to save : " + projectXml.name!)
        
                project.setValue(projectXml.id, forKey: "id")
                project.setValue(projectXml.name, forKey: "name")
                project.setValue(projectXml.desc, forKey: "desc")
                project.setValue(projectXml.parentProjectId, forKey: "parentProjectId")
                project.setValue(projectXml.href, forKey: "href")
                project.setValue(projectXml.webUrl, forKey: "webUrl")
        
                do {
                    try managedContext.save()
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }

        
    }
    
    func deleteAll() {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.executeRequest(deleteRequest)
            try managedContext.save()
        } catch {
            print (error)
        }
        
        
    }
    
    func getAll() -> [Project] {
        let managedContext = appDelegate.managedObjectContext
        var projects:[Project] = []
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
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
