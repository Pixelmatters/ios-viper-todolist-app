//
//  Todo+CoreDataClass.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Todo)
public class Todo: NSManagedObject {

    class func fetchAll(from context: NSManagedObjectContext) -> [Todo] {
        let request: TodoFetchRequest = self.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    class func fetch(createdAt: Date, from context: NSManagedObjectContext) -> Todo? {
        let request: TodoFetchRequest = self.fetchRequest()
        request.predicate = NSPredicate(format: "createdAt = %@", createdAt as NSDate)
        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            return nil
        }
    }
    
    class func save(title: String, to context: NSManagedObjectContext) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "Todo", in: context)!
        let managedTodo = Todo(entity: entity, insertInto: context)
        managedTodo.title = title
        managedTodo.completed = false
        let now = Date()
        managedTodo.createdAt = now
        managedTodo.updatedAt = now
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func update(completed: Bool, createdAt: Date, on context: NSManagedObjectContext) -> Bool {
        let todo = self.fetch(createdAt: createdAt, from: context)
        guard let updateTodo = todo else { return false }
        updateTodo.completed = completed
        updateTodo.updatedAt = Date()
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func delete(createdAt: Date, from context: NSManagedObjectContext) -> Bool {
        let todo = self.fetch(createdAt: createdAt, from: context)
        guard let deleteTodo = todo else { return false }
        context.delete(deleteTodo)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
}
