//
//  ButtonBar.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import SwiftUI

struct ButtonBar: View {
    let taskCount: Int
    let addAction: () -> Void

    var body: some View {
        HStack {
            Text("\(taskCount) задач")
                .foregroundColor(.white)
            Spacer()
            Button(action: addAction) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.black)
    }
}
