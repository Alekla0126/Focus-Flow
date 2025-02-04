//
//  TaskListView.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var presenter: TaskPresenter
    @State private var searchText = ""
    @State private var filteredTasks: [TodoTask] = []
    @State private var isEditing = false
    @State private var selectedTask: TodoTask?

    var displayedTasks: [TodoTask] {
        filteredTasks
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in  // ✅ Ensures full screen
                VStack(spacing: 0) {
                    // ✅ Header Title
                    HStack {
                        Text("Задачи")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.top, 20)

                    Spacer(minLength: 10)

                    // ✅ Search Bar
                    CustomSearchBar(text: $searchText)
                        .onChange(of: searchText) { _ in updateFilteredTasks() }
                        .padding(.horizontal)
                        .padding(.bottom, 12)

                    // ✅ Full-Screen ScrollView
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(displayedTasks.indices, id: \.self) { index in
                                VStack(spacing: 0) {
                                    TaskRowView(
                                        task: displayedTasks[index],
                                        presenter: presenter,
                                        selectedTask: $selectedTask,
                                        isEditing: $isEditing
                                    )
                                    .padding(.horizontal)
                                    .background(Color.black)

                                    // ✅ Thin White Divider (Except Last Task)
                                    if index < displayedTasks.count - 1 {
                                        Divider()
                                            .frame(height: 1)
                                            .background(Color.white.opacity(0.5))
                                            .padding(.horizontal, 16)
                                    }
                                }
                            }
                        }
                        .frame(minHeight: geometry.size.height - 140) // ✅ Ensures it fills available space
                    }

                    // ✅ Bottom Bar
                    HStack {
                        Spacer()
                        Text("\(presenter.tasks.count) Задач")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()

                        Button(action: {
                            let newTask = presenter.addTask(title: "Новая задача", description: "")
                            selectedTask = newTask
                            isEditing = true
                        }) {
                            Image(systemName: "square.and.pencil")
                                .font(.title)
                                .foregroundColor(.yellow)
                        }
                        .padding(.trailing)
                    }
                    .padding()
                    .background(Color.black)
                }
                .frame(width: geometry.size.width, height: geometry.size.height) // ✅ Forces full-screen size
                .background(Color.black.ignoresSafeArea())
                .navigationBarHidden(true)
                .onAppear {
                    presenter.loadTasks()
                    updateFilteredTasks()
                }
                .fullScreenCover(item: $selectedTask) { task in
                    EditTaskView(task: task, presenter: presenter)
                }
            }
        }
        .background(Color.black.ignoresSafeArea())
    }

    private func updateFilteredTasks() {
        DispatchQueue.main.async {
            if searchText.isEmpty {
                filteredTasks = presenter.tasks
            } else {
                filteredTasks = presenter.tasks.filter { task in
                    task.title.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }
}
