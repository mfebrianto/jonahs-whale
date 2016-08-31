//
//  core.swift
//  JonahsWhale
//
//  Created by michael febrianto on 24/08/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import Alamofire

class Core {
    
    func get(url: String) {
        Alamofire.request(.GET, url)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
    
    func post() {
        
    }
    
    
}