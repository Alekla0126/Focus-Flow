//
//  TaskRowView.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import SwiftUI

struct TaskRowView: View {
    @State private var showEditScreen = false
    @State var task: TodoTask
    var presenter: TaskPresenter
    @Binding var selectedTask: TodoTask?
    @Binding var isEditing: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                // ✅ Toggle Task Completion (Checkmark when done, Circle when not)
                Button(action: {
                    task.isCompleted.toggle()
                    presenter.toggleTaskCompletion(task)
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .yellow : .gray)
                        .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())

                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundColor(task.isCompleted ? .gray : .white)
                        .strikethrough(task.isCompleted, color: .gray)

                    Text(task.date.formatted(date: .numeric, time: .omitted))
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()
            }

            Text(task.description)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.leading, 40)
        }
        .padding(.vertical, 8)
        .background(Color.black)
        .listRowBackground(Color.black)
        .contentShape(Rectangle())
        .onTapGesture {
            selectedTask = task
            isEditing = true
        }
        .contextMenu {
            Button(action: {
                selectedTask = task
                isEditing = true
            }) {
                Label("Редактировать", systemImage: "square.and.pencil")
            }

            Button(action: { presenter.shareTask(task) }) {
                Label("Поделиться", systemImage: "square.and.arrow.up")
            }

            Button(role: .destructive, action: { presenter.removeTask(task) }) {
                Label("Удалить", systemImage: "trash")
            }
        }
    }
}
