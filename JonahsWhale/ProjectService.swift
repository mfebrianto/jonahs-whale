//
//  ProjectService.swift
//  JonahsWhale
//
//  Created by michael febrianto on 31/08/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import SWXMLHash
import Alamofire
import XCGLogger
import CoreData

final class ProjectService {
    
    let log = XCGLogger.defaultInstance()
    
    var valueHandle :((String) -> ())?
    var errorHandle :((NSError)->())?
    
    func success(value:(String) -> ())->Self{
        //pass success handle
        self.valueHandle = value
        return self
    }
    
    func error(error:(NSError)->())->Self{
        //pass error handle
        self.errorHandle = error
        return self
    }
    
    static func parse(result: String) -> [ProjectXml] {
        let parsedXml = SWXMLHash.parse(result)
        var projectXmls: [ProjectXml] = []
        
        do{
            projectXmls = try parsedXml["projects"]["project"].value()
        } catch {
            print("Error info: \(error)")
        }
        
        return projectXmls
    }
    
    static func saveAll(projectXmls: [ProjectXml]){
        let dataController = DataController().managedObjectContext
        let log = XCGLogger.defaultInstance()

        let entity =  NSEntityDescription.entityForName("Project",
                                                        inManagedObjectContext:dataController)
        
        for projectXml in projectXmls {
            let project = NSManagedObject(entity: entity!,
                                          insertIntoManagedObjectContext: dataController)
            
            log.debug("trying to save : " + projectXml.name!)

            project.setValue(projectXml.id, forKey: "id")
            project.setValue(projectXml.name, forKey: "name")
            project.setValue(projectXml.desc, forKey: "desc")
            project.setValue(projectXml.parentProjectId, forKey: "parentProjectId")
            project.setValue(projectXml.href, forKey: "href")
            project.setValue(projectXml.webUrl, forKey: "webUrl")
            
            do {
                try dataController.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        

    }
    
    static func getAll() -> ProjectService {
        let projectService = ProjectService()
        let url = Constants.Teamcity.prot + "://" +
            Constants.Teamcity.username + ":" +
            Constants.Teamcity.password + "@" +
            Constants.Teamcity.domain +
            Constants.Teamcity.restPath + "projects"

        
        Alamofire.request(.GET, url)
            .validate()
            .responseString { response in
                switch response.result {
                case .Success(let value):
                    projectService.valueHandle?(value)
                    let projectXmls = parse(value)
                    saveAll(projectXmls)
                    
                case .Failure(let error):
                    projectService.errorHandle?(error)
                }
        }
        
        return projectService
    }
    
}