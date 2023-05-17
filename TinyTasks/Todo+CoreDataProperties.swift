//
//  Todo+CoreDataProperties.swift
//  TinyTasks
//
//  Created by Victor Mihaita on 17.05.2023.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var id: String?
    @NSManaged public var index: Int16
    @NSManaged public var isList: Bool
    @NSManaged public var name: String?
    @NSManaged public var todos: NSOrderedSet?

}

// MARK: Generated accessors for todos
extension Todo {

    @objc(insertObject:inTodosAtIndex:)
    @NSManaged public func insertIntoTodos(_ value: Todo, at idx: Int)

    @objc(removeObjectFromTodosAtIndex:)
    @NSManaged public func removeFromTodos(at idx: Int)

    @objc(insertTodos:atIndexes:)
    @NSManaged public func insertIntoTodos(_ values: [Todo], at indexes: NSIndexSet)

    @objc(removeTodosAtIndexes:)
    @NSManaged public func removeFromTodos(at indexes: NSIndexSet)

    @objc(replaceObjectInTodosAtIndex:withObject:)
    @NSManaged public func replaceTodos(at idx: Int, with value: Todo)

    @objc(replaceTodosAtIndexes:withTodos:)
    @NSManaged public func replaceTodos(at indexes: NSIndexSet, with values: [Todo])

    @objc(addTodosObject:)
    @NSManaged public func addToTodos(_ value: Todo)

    @objc(removeTodosObject:)
    @NSManaged public func removeFromTodos(_ value: Todo)

    @objc(addTodos:)
    @NSManaged public func addToTodos(_ values: NSOrderedSet)

    @objc(removeTodos:)
    @NSManaged public func removeFromTodos(_ values: NSOrderedSet)

}

extension Todo : Identifiable {

}
