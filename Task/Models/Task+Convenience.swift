//
//  Task+Convenience.swift
//  Task
//
//  Created by Nic Gibson on 6/19/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    convenience init(name: String,due: Date? = nil, notes: String? = nil, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
        self.due = due
        self.notes = notes
    }
}
