//
//  TaskEntityExtension.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import Foundation
import CoreData

extension TaskEntity {
    func toTask() -> TodoTask {
        return TodoTask(
            id: self.id ?? UUID(),
            title: self.title ?? "Untitled",
            description: self.taskDescription ?? "",
            date: self.date ?? Date(),
            isCompleted: self.isCompleted
        )
    }
}
