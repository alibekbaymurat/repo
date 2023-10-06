//
//  ContentScrollViewBuilder.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 31.07.2023.
//

import SwiftUI

struct ContentScrollViewBuilder<Content:View>: View {
    
    let isCommentSheet: Bool
    init(isCommentSheet: Bool, @ViewBuilder content: () -> Content) {
        self.isCommentSheet = isCommentSheet
        self.content = content()
    }
    
    // переменная для вывода шита фильтрации контента
    @State private var showFilterSheet = false
    
    // переменная для выбора типа контента
    @State private var selectedContentType: ContentType = .all
    
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        isCommentSheet = false
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ContentTypePickerAndFilter(isCommentSheet: isCommentSheet, showFilterSheet: $showFilterSheet, selectedContentType: $selectedContentType)
                    .padding(8)
                
                ForEach(1...9, id: \.self) { _ in
                    content
                    
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showFilterSheet) {
            ContentFilterView()
        }
    }
}
