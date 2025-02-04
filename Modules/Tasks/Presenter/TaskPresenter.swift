//
//  TaskPresenter.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import Foundation

protocol TaskPresenterProtocol: ObservableObject {
    var tasks: [TodoTask] { get set }
    func loadTasks()
    func addTask(title: String, description: String) -> TodoTask // ✅ Add return type
    func editTask(_ task: TodoTask)
    func removeTask(_ task: TodoTask)
    func toggleTaskCompletion(_ task: TodoTask)
}

class TaskPresenter: ObservableObject, TaskPresenterProtocol {
    private let interactor: TaskInteractorProtocol

    @Published var tasks: [TodoTask] = []

    init(interactor: TaskInteractorProtocol) {
        self.interactor = interactor
        loadTasks()
    }

    /// ✅ Load tasks from Core Data or API
    func loadTasks() {
        interactor.fetchTasks { [weak self] savedTasks in
            DispatchQueue.main.async {
                if savedTasks.isEmpty && !UserDefaults.standard.bool(forKey: "hasLoadedTasks") {
                    self?.interactor.loadTasksFromAPI {
                        self?.interactor.fetchTasks { newTasks in
                            DispatchQueue.main.async {
                                self?.tasks = newTasks
                                UserDefaults.standard.setValue(true, forKey: "hasLoadedTasks") // ✅ Marks as loaded
                            }
                        }
                    }
                } else {
                    self?.tasks = savedTasks
                }
            }
        }
    }

    /// ✅ Add a new task and return it
    func addTask(title: String, description: String) -> TodoTask {
        let newTask = TodoTask(
            id: UUID(),
            title: title,
            description: description,
            date: Date(),
            isCompleted: false
        )
        
        tasks.append(newTask)
        interactor.saveTask(newTask) { [weak self] in
            DispatchQueue.main.async {
                self?.loadTasks()
            }
        }

        return newTask // ✅ Ensure it returns the created task
    }


    /// ✅ Edit an existing task
    func editTask(_ task: TodoTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            interactor.saveTask(task) { [weak self] in
                DispatchQueue.main.async {
                    self?.loadTasks()
                }
            }
        }
    }

    /// ✅ Remove a task
    func removeTask(_ task: TodoTask) {
        tasks.removeAll { $0.id == task.id }
        interactor.deleteTask(task) { [weak self] in
            DispatchQueue.main.async {
                self?.loadTasks()
            }
        }
    }

    /// ✅ Toggle task completion
    func toggleTaskCompletion(_ task: TodoTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            interactor.saveTask(tasks[index]) { [weak self] in
                DispatchQueue.main.async {
                    self?.loadTasks()
                }
            }
        }
    }
    
    /// ✅ Share a task (newly added method)
    func shareTask(_ task: TodoTask) {
        // Implement your share functionality here.
        // For example, you could post a notification, log the share, or trigger a share sheet.
        print("Sharing task: \(task.title)")
    }
}
