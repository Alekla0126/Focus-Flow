//
//  ContentView.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.date, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<TaskEntity>

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    NavigationLink {
                        Text("Task: \(task.title ?? "Untitled")")
                    } label: {
                        Text(task.title ?? "Untitled")
                    }
                }
                .onDelete(perform: deleteTasks)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addTask) {
                        Label("Add Task", systemImage: "plus")
                    }
                }
            }
            Text("Select a task")
        }
    }

    private func addTask() {
        withAnimation {
            let newTask = TaskEntity(context: viewContext)
            newTask.id = UUID()
            newTask.title = "New Task"
            newTask.taskDescription = "Task Description"
            newTask.date = Date()
            newTask.isCompleted = false

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteTasks(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
