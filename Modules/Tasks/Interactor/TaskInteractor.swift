//
//  TaskInteractor.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import Foundation
import CoreData

protocol TaskInteractorProtocol {
    func fetchTasks(completion: @escaping ([TodoTask]) -> Void)
    func saveTask(_ task: TodoTask, completion: @escaping () -> Void)
    func deleteTask(_ task: TodoTask, completion: @escaping () -> Void)
    func loadTasksFromAPI(completion: @escaping () -> Void)
}

class TaskInteractor: TaskInteractorProtocol {
    let persistentContainer: NSPersistentContainer

    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }

    // ✅ Fetch from Core Data
    func fetchTasks(completion: @escaping ([TodoTask]) -> Void) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do {
            let entities = try context.fetch(request)
            let tasks = entities.map { $0.toTask() }
            completion(tasks)
        } catch {
            completion([])
        }
    }

    // ✅ Save to Core Data
    func saveTask(_ task: TodoTask, completion: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        let entity = TaskEntity(context: context)
        entity.id = task.id
        entity.title = task.title
        entity.taskDescription = task.description
        entity.date = task.date
        entity.isCompleted = task.isCompleted
        do {
            try context.save()
            completion()
        } catch {
            completion()
        }
    }

    // ✅ Delete from Core Data
    func deleteTask(_ task: TodoTask, completion: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        do {
            let entities = try context.fetch(request)
            for entity in entities {
                context.delete(entity)
            }
            try context.save()
            completion()
        } catch {
            completion()
        }
    }

    // ✅ Fetch from API and Save to Core Data
    func loadTasksFromAPI(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(TodoResponse.self, from: data)

                let context = self.persistentContainer.viewContext
                apiResponse.todos.forEach { apiTask in
                    let taskEntity = TaskEntity(context: context)
                    taskEntity.id = UUID()
                    taskEntity.title = apiTask.todo
                    taskEntity.taskDescription = ""
                    taskEntity.date = Date()
                    taskEntity.isCompleted = apiTask.completed
                }

                try context.save()
                completion()
            } catch {
                completion()
            }
        }.resume()
    }
}

// ✅ API Models
struct TodoResponse: Codable {
    let todos: [APITodo]
}

struct APITodo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
}
