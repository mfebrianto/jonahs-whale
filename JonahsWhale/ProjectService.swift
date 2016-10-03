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
        return getAll(domain: Constants.Teamcity.domain,
                      username: Constants.Teamcity.username,
                      password: Constants.Teamcity.password)
    }
    
    static func getAll(domain: String, username: String, password: String) -> ProjectService {
        let projectService = ProjectService()
        let url = Constants.Teamcity.prot + "://" +
            username + ":" + password + "@" + domain +
            Constants.Teamcity.restPath + "projects"
    
    
        Alamofire.request(url)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let value):
                    projectService.valueHandle?(value)
                    let projectXmls = parse(value)
    
                    ProjectDao().deleteAll()
                    ProjectDao().saveAll(projectXmls)
    
                case .failure(let error):
                    projectService.errorHandle?(error as NSError)
            }
        }
    
        return projectService
    }

}
