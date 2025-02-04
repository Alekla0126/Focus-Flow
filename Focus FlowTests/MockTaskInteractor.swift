//
//  MockTaskInteractor.swift
//  Focus FlowTests
//
//  Created by user on 04.02.2025.
//

import Foundation
@testable import Focus_Flow

class MockTaskInteractor: TaskInteractorProtocol {
    var mockTasks: [TodoTask] = [] // ✅ In-memory task storage

    func fetchTasks(completion: @escaping ([TodoTask]) -> Void) {
        completion(mockTasks) // ✅ Simulates returning saved tasks
    }

    func saveTask(_ task: TodoTask, completion: @escaping () -> Void) {
        if let index = mockTasks.firstIndex(where: { $0.id == task.id }) {
            mockTasks[index] = task // ✅ Update task if it already exists
        } else {
            mockTasks.append(task) // ✅ Add new task
        }
        completion()
    }

    func deleteTask(_ task: TodoTask, completion: @escaping () -> Void) {
        mockTasks.removeAll { $0.id == task.id } // ✅ Remove task
        completion()
    }

    func loadTasksFromAPI(completion: @escaping () -> Void) {
        let fakeAPIResponse = [
            TodoTask(id: UUID(), title: "Task 1", description: "Description 1", date: Date(), isCompleted: false),
            TodoTask(id: UUID(), title: "Task 2", description: "Description 2", date: Date(), isCompleted: true)
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // ✅ Simulate network delay
            self.mockTasks = fakeAPIResponse
            completion()
        }
    }
}

