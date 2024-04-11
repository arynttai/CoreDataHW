import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataLessonN1")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func createTask(name: String, deadline: Date) {
        let context = persistentContainer.viewContext
        let task = TodoListTask(context: context)
        task.deadline = deadline
        task.name = name
        task.isDone = false
        saveContext()
    }
    
    func getTasks(filterCompleted: Bool? = nil) -> [TodoListTask] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<TodoListTask> = TodoListTask.fetchRequest()
        
        if let filterCompleted = filterCompleted {
            request.predicate = NSPredicate(format: "isDone == %@", NSNumber(value: filterCompleted))
        }
        
        do {
            return try context.fetch(request)
        } catch {
            print("Ошибка при получении задач: \(error)")
            return []
        }
    }
    
    func updateTask(task: TodoListTask) {
        task.isDone.toggle()
        saveContext()
    }
    
    func deleteTask(task: TodoListTask) {
        let context = persistentContainer.viewContext
        context.delete(task)
        saveContext()
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
