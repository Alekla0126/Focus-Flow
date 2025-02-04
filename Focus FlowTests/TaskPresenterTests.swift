//
//  TaskPresenterTests.swift
//  Focus FlowTests
//
//  Created by user on 04.02.2025.
//

@testable import Focus_Flow
import XCTest

class TaskPresenterTests: XCTestCase {
    var presenter: TaskPresenter!
    var mockInteractor: MockTaskInteractor!

    override func setUp() {
        super.setUp()
        mockInteractor = MockTaskInteractor() // ✅ Now MockTaskInteractor exists
        presenter = TaskPresenter(interactor: mockInteractor)
    }

    override func tearDown() {
        mockInteractor = nil
        presenter = nil
        super.tearDown()
    }

    func testAddTask() {
        let initialCount = presenter.tasks.count
        let newTask = presenter.addTask(title: "Test Task", description: "Description") // ✅ Fixed usage

        XCTAssertEqual(presenter.tasks.count, initialCount + 1, "Task count should increase after adding a task.")
        XCTAssertEqual(presenter.tasks.last?.title, newTask.title, "Last task should match the added task.")
    }


    func testEditTask() {
        let newTask = TodoTask(id: UUID(), title: "Task 1", description: "Desc 1", date: Date(), isCompleted: false)

        presenter.addTask(title: newTask.title, description: newTask.description)

        var editedTask = presenter.tasks.first!
        editedTask.title = "Updated Task"
        presenter.editTask(editedTask)

        XCTAssertEqual(presenter.tasks.first?.title, "Updated Task", "Task should be updated.")
    }

    func testRemoveTask() {
        let newTask = TodoTask(id: UUID(), title: "Task to Remove", description: "Remove me", date: Date(), isCompleted: false)
        
        presenter.addTask(title: newTask.title, description: newTask.description)
        presenter.removeTask(presenter.tasks.first!)

        XCTAssertFalse(presenter.tasks.contains(where: { $0.id == newTask.id }), "Task should be removed from list.")
    }

    func testLoadTasksFromAPI() {
        let expectation = XCTestExpectation(description: "Carga de tareas desde API")

        XCTAssertEqual(presenter.tasks.count, 0, "Inicialmente las tareas deben estar vacías.")

        mockInteractor.loadTasksFromAPI {
            DispatchQueue.main.async {
                self.presenter.loadTasks()
                expectation.fulfill() // ✅ Se cumple la expectativa después de cargar los datos
            }
        }

        wait(for: [expectation], timeout: 5.0) // ✅ Esperar hasta 5 segundos por la respuesta
        XCTAssertFalse(presenter.tasks.isEmpty, "Las tareas deberían haberse cargado desde la API.")
    }
}
