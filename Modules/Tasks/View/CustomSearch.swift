//
//  CustomSearch.swift
//  Focus Flow
//
//  Created by user on 04.02.2025.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $text)
                .foregroundColor(.gray) // ✅ Now text matches the icon color
                .disableAutocorrection(true)
                .placeholder(when: text.isEmpty) { // ✅ Ensures placeholder is also gray
                    Text("Search").foregroundColor(.gray)
                }

            Image(systemName: "mic.fill")
                .foregroundColor(.gray)
        }
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// ✅ Extension to set placeholder color when TextField is empty
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        overlay(
            Group {
                if shouldShow {
                    placeholder()
                        .padding(.horizontal, 5)
                }
            },
            alignment: alignment
        )
    }
}
