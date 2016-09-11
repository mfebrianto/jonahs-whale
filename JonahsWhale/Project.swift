//
//  Project.swift
//  JonahsWhale
//
//  Created by michael febrianto on 31/08/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import SWXMLHash

final class Project: XMLIndexerDeserializable {

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
    
    static func getDescription(node: XMLIndexer) -> String {
        var description: String = ""
        
        do {
            try description = node.value(ofAttribute: "description")
        }
        catch is XMLDeserializationError {
            description = ""
        }
        catch {
            print(NSThread.callStackSymbols())
        }

        return description
    }
    
    static func getParentProjectId(node: XMLIndexer) -> String {
        var parentProjectId: String = ""
        
        do {
            try parentProjectId = node.value(ofAttribute: "parentProjectId")
        }
        catch is XMLDeserializationError {
            parentProjectId = ""
        }
        catch {
            print(NSThread.callStackSymbols())
        }
        
        return parentProjectId
    }
    
    
    static func deserialize(node: XMLIndexer) throws -> Project {
        return try Project(
            id: node.value(ofAttribute: "id"),
            name: node.value(ofAttribute: "name"),
            description: getDescription(node),
            parentProjectId: getParentProjectId(node),
            href: node.value(ofAttribute: "href"),
            webUrl: node.value(ofAttribute: "webUrl")
        )
    }
    
    static func validate(value: String) -> String {
        if value.isEmpty {
            return ""
        }
        else {
            return value
        }
    }
    
}