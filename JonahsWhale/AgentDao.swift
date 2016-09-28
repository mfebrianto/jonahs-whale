//
//  AgentDao.swift
//  JonahsWhale
//
//  Created by michael febrianto on 27/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import XCGLogger
import CoreData


class AgentDao {
    
    let entityName = "Agent"
    let log = XCGLogger.defaultInstance()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    func save(username: String, password: String, uri: String) {
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName(entityName, inManagedObjectContext:managedContext)

        let agent = NSManagedObject(entity: entity!,
                        insertIntoManagedObjectContext:managedContext)
        
        agent.setValue(NSUUID().UUIDString, forKey: "id")
        agent.setValue(username, forKey: "username")
        agent.setValue(password, forKey: "password")
        agent.setValue(uri, forKey: "uri")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    func getAll() -> [Agent] {
        let managedContext = appDelegate.managedObjectContext
        var agents:[Agent] = []
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            agents = results as! [Agent]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return agents
    }
}