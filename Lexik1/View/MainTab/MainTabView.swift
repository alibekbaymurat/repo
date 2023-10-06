//
//  MainTabView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 31.07.2023.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var selection = Tab.feed
    @StateObject var fullPostViewModel = FullPostViewModel()
    
    var body: some View {
        if let user = authVM.currentUser {
            VStack(spacing: 0) {
                switch selection {
                case .library: LibraryView()
                case .feed: FeedView()
                case .preference: PreferenceView()
                }
                
                if fullPostViewModel.showTabBar {
                    MainTabButtonView()
                }
            }
            .environmentObject(fullPostViewModel)
        }
    }
}

extension MainTabView {
    enum Tab: String, CaseIterable {
        case library = "Библиотека",
             feed = "Новости",
             preference = "Настройки"
        
        var image: String {
            switch self {
            case .library: return "books.vertical"
            case .feed: return "newspaper"
            case .preference: return "gear"
            }
        }
    }
    func MainTabButtonView() -> some View {
        HStack(spacing: 65) {
            ForEach(Tab.allCases, id: \.self) { item in
                VStack {
                    Image(systemName: item.image)
                        .font(.title2)
                    Text(item.rawValue)
                        .font(.caption)
                }
                .onTapGesture {
                    selection = item
                }
                .fontWeight(.medium)
                .foregroundColor(selection == item ? .blue : .gray)
            }
            .padding(.top, 6)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.ultraThinMaterial)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
