//
//  Todo+CoreDataProperties.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//
//

import Foundation
import CoreData

public typealias TodoFetchRequest = NSFetchRequest<Todo>

extension Todo {

    @nonobjc public class func fetchRequest() -> TodoFetchRequest {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var createdAt: Date?
    @NSManaged public var title: String?
    @NSManaged public var updatedAt: Date?

}
