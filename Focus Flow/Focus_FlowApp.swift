//
//  Focus_FlowApp.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import SwiftUI

@main
struct Focus_FlowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let interactor = TaskInteractor(container: persistenceController.container)
            let presenter = TaskPresenter(interactor: interactor)
            TaskListView(presenter: presenter)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
