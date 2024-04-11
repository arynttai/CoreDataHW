//
//  TodoListTask+CoreDataProperties.swift
//  CoreDataLessonN1
//
//  Created by Swift on 11.04.2024.
//
//

import Foundation
import CoreData


extension TodoListTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListTask> {
        return NSFetchRequest<TodoListTask>(entityName: "TodoListTask")
    }

    @NSManaged public var name: String?
    @NSManaged public var deadline: Date?
    @NSManaged public var isDone: Bool

}

extension TodoListTask : Identifiable {

}
