//
//  FeedView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 31.07.2023.
//

import SwiftUI

struct FeedView: View {
    // переменная для выбора типа новостей
    @State private var selectedFeedType = FeedType.publication
    
    
    var body: some View {
        MainTabViewBuilder(title: "Лента новостей") {
            VStack(spacing: 0) {
                FeedTypePicker()
                
                ContentScrollViewBuilder {
                    ContentCellPatternView(contentType: .comment, isRepost: false)
                }
            }
            .modifier(FeedViewToolbarModifier())
        }
    }
}

extension FeedView {
    // набор тулбаров FeedView
    struct FeedViewToolbarModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        ProfileMenuButtonView()
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SearchView()
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                        
                        NavigationLink {
                            NotificationView()
                        } label: {
                            Image(systemName: "bell")
                        }
                    }
                }
        }
    }
    
    // пикер типа новостей
    func FeedTypePicker() -> some View {
        Picker("", selection: $selectedFeedType) {
            ForEach(FeedType.allCases, id: \.self) { item in
                Text(item.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
    
    // перечисление всех типов новостей
    enum FeedType: String, CaseIterable {
        case publication = "Подписки",
             recommendation = "Рекомендации",
             actual = "Актуальные"
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
