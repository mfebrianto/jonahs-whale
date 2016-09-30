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
    let log = XCGLogger.default
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func save(_ username: String, password: String, uri: String) {
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entity(forEntityName: entityName, in:managedContext)

        let agent = NSManagedObject(entity: entity!,
                        insertInto:managedContext)
        
        agent.setValue(UUID().uuidString, forKey: "id")
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
        
        let fetchRequest = NSFetchRequest<Agent>(entityName: entityName)
        
        do {
            let results =
                try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            agents = results as! [Agent]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return agents
    }
}
