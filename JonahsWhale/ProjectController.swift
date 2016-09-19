//
//  ProjectController.swift
//  JonahsWhale
//
//  Created by michael febrianto on 19/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import CoreData

class ProjectController {
    
    let dataController = DataController().managedObjectContext
    
    func getAllProjects() -> [Project] {
        
        var projects:[Project] = []
        
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("Project", inManagedObjectContext: dataController)
        fetchRequest.entity = entityDescription
        
        do {
            let results = try dataController.executeFetchRequest(fetchRequest)
            projects = results as! [Project]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return projects
    }
}