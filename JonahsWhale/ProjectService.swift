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
    
    let log = XCGLogger.default
    
    var valueHandle :((String) -> ())?
    var errorHandle :((NSError)->())?
    
    func success(_ value:@escaping (String) -> ())->Self{
        //pass success handle
        self.valueHandle = value
        return self
    }
    
    func error(_ error:@escaping (NSError)->())->Self{
        //pass error handle
        self.errorHandle = error
        return self
    }
    
    static func parse(_ result: String) -> [ProjectXml] {
        let parsedXml = SWXMLHash.parse(result)
        var projectXmls: [ProjectXml] = []
        
        do{
            projectXmls = try parsedXml["projects"]["project"].value()
        } catch {
            print("Error info: \(error)")
        }
        
        return projectXmls
    }
    
    static func getAll() -> ProjectService {
        
        let agent = Agent()
        agent.uri = Constants.Teamcity.domain
        agent.username = Constants.Teamcity.username
        agent.password = Constants.Teamcity.password
        
        return getAll(agent: agent)
    }
    
    static func getAll(agent: Agent) -> ProjectService {
        let projectService = ProjectService()
        let url = Constants.Teamcity.prot + "://" +
            agent.username! as String + ":" +
            agent.password! as String + "@" +
            agent.uri! as String +
            Constants.Teamcity.restPath + "projects"
    
    
        Alamofire.request(url)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let value):
                    projectService.valueHandle?(value)
                    let projectXmls = parse(value)
    
                    ProjectDao().deleteAll()
                    ProjectDao().saveAll(projectXmls, agent: agent)
    
                case .failure(let error):
                    projectService.errorHandle?(error as NSError)
            }
        }
    
        return projectService
    }

}
