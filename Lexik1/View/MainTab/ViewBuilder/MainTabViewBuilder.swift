//
//  MainTabViewBuilder.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 31.07.2023.
//

import SwiftUI

struct MainTabViewBuilder<Content:View>: View {
    let title: String
    @ViewBuilder let content: Content
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            content
                .navigationBarTitle(title, displayMode: .inline)
                .scrollContentBackground(.hidden)
                .background(colorScheme == .light ? Color(.systemGray6) : Color(.systemGray5))
        }
    }
}

