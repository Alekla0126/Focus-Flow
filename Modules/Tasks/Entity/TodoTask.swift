//
//  TodoTask.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import Foundation

struct TodoTask: Identifiable {
    let id: UUID
    var title: String
    var description: String
    let date: Date
    var isCompleted: Bool
}
