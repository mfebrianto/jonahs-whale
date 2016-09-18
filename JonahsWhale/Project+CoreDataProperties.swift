//
//  Project+CoreDataProperties.swift
//  JonahsWhale
//
//  Created by michael febrianto on 16/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Project {

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var desc: String?
    @NSManaged var parentProjectId: String?
    @NSManaged var href: String?
    @NSManaged var webUrl: String?

}
