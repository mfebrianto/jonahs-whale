//
//  ProjectXml.swift
//  JonahsWhale
//
//  Created by michael febrianto on 19/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import SWXMLHash
import CoreData

final class ProjectXml: XMLIndexerDeserializable {
    
    var id: String?
    var name: String?
    var desc: String?
    var parentProjectId: String?
    var href: String?
    var webUrl: String?

    
    init(id: String, name: String, description: String, parentProjectId: String, href: String, webUrl: String) {
        self.id = id
        self.name = name
        self.desc = description
        self.parentProjectId = parentProjectId
        self.href = href
        self.webUrl = webUrl
    }
    
    static func getDescription(_ node: XMLIndexer) -> String {
        var description: String = ""
        
        do {
            try description = node.value(ofAttribute: "description")
        }
        catch is XMLDeserializationError {
            description = ""
        }
        catch {
            print(Thread.callStackSymbols)
        }
        
        return description
    }
    
    static func getParentProjectId(_ node: XMLIndexer) -> String {
        var parentProjectId: String = ""
        
        do {
            try parentProjectId = node.value(ofAttribute: "parentProjectId")
        }
        catch is XMLDeserializationError {
            parentProjectId = ""
        }
        catch {
            print(Thread.callStackSymbols)
        }
        
        return parentProjectId
    }
    
    
    static func deserialize(_ node: XMLIndexer) throws -> ProjectXml {
        return try ProjectXml(
            id: node.value(ofAttribute: "id"),
            name: node.value(ofAttribute: "name"),
            description: getDescription(node),
            parentProjectId: getParentProjectId(node),
            href: node.value(ofAttribute: "href"),
            webUrl: node.value(ofAttribute: "webUrl")
        )
    }
    
    static func validate(_ value: String) -> String {
        if value.isEmpty {
            return ""
        }
        else {
            return value
        }
    }
    
}
