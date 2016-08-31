//
//  Project.swift
//  JonahsWhale
//
//  Created by michael febrianto on 31/08/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation

class Project {

    var id: String
    var name: String
    var description: String
    var parentProjectId: String
    var href: String
    var webUrl: String
    
    init(id: String, name: String, description: String, parentProjectId: String, href: String, webUrl: String) {
        self.id = id
        self.name = name
        self.description = description
        self.parentProjectId = parentProjectId
        self.href = href
        self.webUrl = webUrl
    }
    
}