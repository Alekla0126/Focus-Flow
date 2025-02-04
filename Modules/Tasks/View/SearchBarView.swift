//
//  SearchBarView.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .foregroundColor(.white)

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
        }
        .padding()
    }
}
