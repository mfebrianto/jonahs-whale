//
//  Agent+CoreDataProperties.swift
//  JonahsWhale
//
//  Created by michael febrianto on 27/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Agent {

    @NSManaged var id: NSNumber?
    @NSManaged var username: String?
    @NSManaged var password: String?
    @NSManaged var uri: String?

}
