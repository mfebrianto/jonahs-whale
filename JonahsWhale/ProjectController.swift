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
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Project")
        
        //3
        do {
            let results = try dataController.executeFetchRequest(fetchRequest)
            projects = results as! [Project]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return projects
        
    }
    
}