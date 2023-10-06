//
//  ContentCellPatternView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 04.08.2023.
//

import SwiftUI

class FullPostViewModel: ObservableObject {
    @Published var showTabBar = true
}

struct ContentCellPatternView: View {
    
    // для определения прокрутки скрол вью и выключения Engagement
    @State private var offset = CGFloat.zero
    
    @State private var showCommentSheet = false
    
    @State private var showEngageBar = false
    
    
    //
    @EnvironmentObject var fullPostViewModel: FullPostViewModel
    
    //
    @ObservedObject var dataExtension = Extension()
    
    // для смены цветовой темы
    @Environment(\.colorScheme) var colorScheme
    
    // для определения типа контента
    let contentType: ContentType
    
    // для определения репостнутый ли контент в основном контенте
    let isRepost: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if contentType == .comment {
                CommentHeaderInFeed()
            }
            
            ContentCellHeader()
            
            Text(dataExtension.data)
                .lineLimit(7)
            
            ShowFullPostButtonAndPageCount()
            
            ContentActionButtonView()
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(colorScheme == .light ? .white : Color(.systemGray6))
        }
        .sheet(isPresented: $showCommentSheet) {
            CommentView()
        }
    }
}

extension ContentCellPatternView {
    
    struct ViewOffsetKey: PreferenceKey {
        typealias Value = CGFloat
        static var defaultValue = CGFloat.zero
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value += nextValue()
        }
    }
    
    ///
    func ShowFullPostButtonAndPageCount() -> some View {
        return HStack {
            NavigationLink("Показать полностью") {
                MainTabViewBuilder(title: "12 стр.") {
                    VStack(alignment: .leading, spacing: 0) {
                        ScrollView {
                            Text(dataExtension.data)
                                .padding(8)
                                .background {
                                    GeometryReader {
                                        Color.clear.preference(key: ViewOffsetKey.self,
                                                               value: -$0.frame(in: .named("scroll")).origin.y)
                                    }
                                }
                                .onPreferenceChange(ViewOffsetKey.self) { _ in
                                    showEngageBar = false
                                }
                        }
                        .onTapGesture {
                            showEngageBar = false
                        }
                        .coordinateSpace(name: "scroll")
                        
                        FullPostTabBar()
                    }
                }
                .toolbarTitleMenu {
                    Button("Перейти к странице") {
                        
                    }
                    
                    Button("Страницы с закладкой") {
                        
                    }
                }
                .onAppear {
                    fullPostViewModel.showTabBar.toggle()
                }
                .onDisappear {
                    fullPostViewModel.showTabBar.toggle()
                }
                .toolbar {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.down")
                    }

                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bookmark")
                    }
                }
            }
            
            Spacer()
            
            Text("197 стр.")
                .foregroundColor(.gray)
        }
        
        func FullPostTabBar() -> some View {
            VStack {
                if showEngageBar {
                    VStack {
                        CommentHeaderInFeed()
                        
                        ContentActionButtonView()
                    }
                    .padding(8)
                }
                
                HStack(spacing: 65) {
                    Menu("Действия") {
                        ForEach(ContentContextMenuAction.allCases, id: \.self) { item in
                            Button(item.rawValue) {
                                
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(.systemGray2))
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }

                    Button("Вовлеченность") {
                        showEngageBar.toggle()
                    }
                }
                .padding(.top, 6)
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(.ultraThinMaterial)
        }
    }
    
    ///вью показывающая все комментарии
    func CommentView() -> some View {
        MainTabViewBuilder(title: "Комментарии") {
            ContentScrollViewBuilder(isCommentSheet: true) {
                ContentCellPatternView(contentType: .comment, isRepost: false)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showCommentSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Назад")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Закрыть все") {
                        UIApplication
                            .shared
                            .connectedScenes
                            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                            .first { $0.isKeyWindow }?
                            .rootViewController?
                            .dismiss(animated: true)
                    }
                }
            }
        }
    }
    /// шапка комментария если он показан в скролле
    func CommentHeaderInFeed() -> some View {
        return VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Text("Ответ к ")
                    .foregroundColor(Color(.systemGray2))
                
                NavigationLink("посту") {
                    
                }
            }
            .font(.subheadline)
            
            Divider()
        }
    }
    
    /// шапка поста (название профиля и контекстное меню)
    func ContentCellHeader() -> some View {
        return VStack(spacing: 8) {
            HStack(spacing: 8) {
                // название профиля
                NavigationLink {
                    ProfileView()
                } label: {
                    Text("Алибек БАЙМУРАТ")
                        .lineLimit(1)
                        .underline()
                        .font(.headline)
                }
                
                Text("@alibek_baimurat")
                    .lineLimit(1)
                    .foregroundColor(.gray)
                
                Spacer()
                
                // контекстное меню
                Menu {
                    ForEach(ContentContextMenuAction.allCases, id: \.self) { item in
                        Button(item.rawValue) {
                            
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(Angle(degrees: 90))
                }
            }
            
            if contentType == .profile {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("4k")
                        
                        NavigationLink {
                            
                        } label: {
                            Text(" подписчиков")
                                .underline()
                        }
                    }
                    .font(.headline)
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Подписаться")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(.systemGray2))
                    .padding(.trailing)
                }
            }
        }
        .foregroundColor(colorScheme == .light ? .black : .white)
    }
    
    /// кнопки взаимодействия с постом а именно:
    ///  - лайк
    ///  - дизлайк
    ///  - комментирование
    ///  - поделиться
    func ContentActionButtonView() -> some View {
        // перечисление всех взаимодействии с постом
        enum ContentAction: String, CaseIterable {
            case uprate = "arrowtriangle.up",
                 downrate = "arrowtriangle.down",
                 comment = "bubble.left",
                 share = "square.and.arrow.up"
            
            var counter: String? {
                switch self {
                case .uprate: return "3K"
                case .downrate: return "10K"
                case .comment: return "100K"
                case .share: return nil
                }
            }
        }
        
        return HStack {
            // все кнопки кроме поделиться
            ForEach(ContentAction.allCases.filter({$0 != .share}), id: \.self) { item in
                Button {
                    switch item {
                    case .comment: showCommentSheet.toggle()
                    case .uprate:
                        break
                    case .downrate:
                        break
                    case .share:
                        break
                    }
                } label: {
                    Label(item.counter ?? "", systemImage: item.rawValue)
                }
                
                Spacer()
            }
            
            // кнопка поделиться
            ShareLink(item: URL(string:"https://www.google.com")!) {
                Image(systemName: ContentAction.share.rawValue)
            }
        }
        .font(.callout)
        .tint(Color(.systemGray2))
        .buttonStyle(.borderedProminent)
    }
}

// перечисление всех действий над постом в контекстном меню
enum ContentContextMenuAction: String, CaseIterable {
    case copyLink = "Копировать ссылку",
         share = "Поделиться",
         repost = "Сделать репост",
         readLater = "Прочитать позже",
         report = "Пожаловаться",
         readOffline = "Читать оффлайн (скачать)",
         statistic = "Показать статистику"
}
