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

final class ProjectService {
    
    var valueHandle :((AnyObject) -> ())?
    var errorHandle :((NSError)->())?
    
    func success(value:(AnyObject) -> ())->Self{
        //pass success handle
        self.valueHandle = value
        return self
    }
    
    func error(error:(NSError)->())->Self{
        //pass error handle
        self.errorHandle = error
        return self
    }
    
    static func getAll()->ProjectService{
        
        print("getAll()")
        
        //concatenate string for request
        let url = Constants.Teamcity.prot + "://" +
            Constants.Teamcity.username + ":" +
            Constants.Teamcity.password + "@" +
            Constants.Teamcity.domain +
            Constants.Teamcity.restPath + "projects"
        
        print("getAll()>>>>"+url)

        return getAll(.GET, urlString: url )
    }
    
    static func getAll(method:Alamofire.Method , urlString:String) -> ProjectService {
        let projectService = ProjectService()
        Alamofire.request(method, urlString)
            .validate()
            .responseString { response in
                switch response.result {
                case .Success(let value):
                    //invoke with your back userobj
                    projectService.valueHandle?(value)
                    print(value)
                case .Failure(let error):
                    projectService.errorHandle?(error)
                }
        }
        return projectService
    }
    
}