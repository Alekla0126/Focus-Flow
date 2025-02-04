//
//  EditTaskView.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var editedTask: TodoTask
    var presenter: TaskPresenter

    init(task: TodoTask, presenter: TaskPresenter) {
        self._editedTask = State(initialValue: task)
        self.presenter = presenter
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 12) {
                // Title Input
                TextField("Название", text: $editedTask.title)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.top, 20)

                // Date Display
                Text(editedTask.date.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.gray)

                // Description Input (FIXED)
                TextEditor(text: $editedTask.description)
                    .foregroundColor(.white)
                    .font(.body)
                    .multilineTextAlignment(.leading)  // Ensures text starts from the left
                    .scrollContentBackground(.hidden)  // Hides default background
                    .background(Color.black)  // Enforces black background
                
                Spacer()
            }
            .padding()
            .background(Color.black.ignoresSafeArea(.all, edges: .all))  // Full black background
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: saveAndClose) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Назад")
                    }
                    .foregroundColor(.yellow)
                    .font(.headline)
                }
            )
        }
        .accentColor(.yellow)  // Ensures back button color is correct
    }

    private func saveAndClose() {
        presenter.editTask(editedTask)
        presentationMode.wrappedValue.dismiss()
    }
}
