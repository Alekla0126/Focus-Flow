//
//  TaskRouter.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import SwiftUI
import CoreData

struct TaskRouter {
    static func createModule(container: NSPersistentContainer) -> TaskListView {
        let interactor = TaskInteractor(container: container)
        let presenter = TaskPresenter(interactor: interactor)
        return TaskListView(presenter: presenter)
    }
}
