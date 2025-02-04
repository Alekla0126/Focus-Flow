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
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
