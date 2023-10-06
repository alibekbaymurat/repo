//
//  NotificationView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 04.08.2023.
//

import SwiftUI

struct NotificationView: View {
    @State private var showNotificationSetupSheet = false
    
    var body: some View {
        MainTabViewBuilder(title: "Уведомления") {
            Form {
                ForEach(NotificationType.allCases, id: \.self) { item in
                    NavigationLink {
                        
                    } label: {
                        LabeledContent(item.rawValue, value: item.value)
                    }
                }
            }
            .toolbar {
                Button {
                    showNotificationSetupSheet.toggle()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
            }
            .sheet(isPresented: $showNotificationSetupSheet) {
                NotificationSetupSheetView()
            }
        }
    }
}

extension NotificationView {
    
    struct NotificationSetupSheetView: View {
        @State private var allNotification = false
        @State private var commentNotification = false
        @State private var mentionNotification = false
        @State private var rateNotification = false
        @State private var subscriberNotification = false
        @State private var repostNotification = false
        
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            MainTabViewBuilder(title: "Настройка уведомлений") {
                Form {
                    Toggle("Все уведомления", isOn: $allNotification)
                        .onChange(of: allNotification) { newValue in
                            commentNotification = newValue
                            mentionNotification = newValue
                            rateNotification = newValue
                            subscriberNotification = newValue
                            repostNotification = newValue
                        }
                    
                    Section {
                        Toggle("Уведомления о комментариях", isOn: $commentNotification)
                        
                        Toggle("Уведомления о упоминаниях", isOn: $mentionNotification)
                        
                        Toggle("Уведомления об оценках", isOn: $rateNotification)
                        
                        Toggle("Уведомления о читателях", isOn: $subscriberNotification)
                        
                        Toggle("Уведомления о репостах", isOn: $repostNotification)
                    }
                    
                    Button("Применить") {
                        
                    }
                }
                .toolbar {
                    Button("Закрыть") {
                        dismiss()
                    }
                }
            }
            .presentationDetents([.fraction(0.6)])
        }
    }
    
    enum NotificationType: String, CaseIterable {
        case comment = "Комментарии к Вашему контенту"
        case mention = "Упоминания Вашего аккаунта в контенте пользователей"
        case rating = "Оценка Вашего контента"
        case subscriber = "Ваши читатели"
        case repost = "Репосты Вашего контента"
        //case donation = "Денежные пожертвования и сообщения"
        case statistic = "Статистика взаимодействия пользователей с Вашим контентом"
        
        var value: String {
            switch self {
            case .comment: return "12"
            case .mention: return "54"
            case .rating: return "23"
            case .subscriber: return "3"
            case .repost: return "12"
            //case .donation: return "2"
            case .statistic: return ""
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
