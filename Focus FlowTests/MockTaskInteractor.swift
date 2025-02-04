//
//  MockTaskInteractor.swift
//  Focus FlowTests
//
//  Created by user on 04.02.2025.
//

import Foundation
@testable import Focus_Flow

class MockTaskInteractor: TaskInteractorProtocol {
    var mockTasks: [TodoTask] = []

    func fetchTasks(completion: @escaping ([TodoTask]) -> Void) {
        completion(mockTasks)
    }

    func saveTask(_ task: TodoTask, completion: @escaping () -> Void) {
        if let index = mockTasks.firstIndex(where: { $0.id == task.id }) {
            mockTasks[index] = task
        } else {
            mockTasks.append(task)
        }
        completion()
    }

    func deleteTask(_ task: TodoTask, completion: @escaping () -> Void) {
        mockTasks.removeAll { $0.id == task.id }
        completion()
    }

    func loadTasksFromAPI(completion: @escaping () -> Void) {
        let apiTasks = [
            TodoTask(id: UUID(), title: "API Task 1", description: "From API", date: Date(), isCompleted: false),
            TodoTask(id: UUID(), title: "API Task 2", description: "From API", date: Date(), isCompleted: true)
        ]
        mockTasks.append(contentsOf: apiTasks)
        completion()
    }
}
