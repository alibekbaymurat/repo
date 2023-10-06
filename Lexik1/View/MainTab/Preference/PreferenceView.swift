//
//  PreferenceView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 31.07.2023.
//

import SwiftUI
import Firebase

struct PreferenceView: View {
    @State private var username = ""
    init() {
        _username = State(initialValue: "kjn")
        _fullname = State(initialValue: "kjn")
    }
    @State private var fullname = ""
    @State private var password = ""
    
    var captionOfProfile: String {
        return "jjj"
    }
    
    @EnvironmentObject var authVM: AuthViewModel
    
    enum LanguageSelectionPreferenceEnum: String, CaseIterable {
        case kazakh = "Қазақ",
             russian = "Русский",
             english = "English"
    }
    // переменная выбранного языка приложения
    @State private var languagePicker: LanguageSelectionPreferenceEnum = .russian
    
    var body: some View {
        MainTabViewBuilder(title: "Настройки") {
            Form {
                Section {
                    NavigationLink("Профиль") {
                        Form {
                            TextField("Имя пользователя", text: $username)
                            
                            TextField("Имя и фамилия (опционально)", text: $fullname)
                            
                            NavigationLink("Редактировать описание профиля") {
                                NewContentCreaterView(initialCaption: captionOfProfile)
                            }
                            
                            Button("Изменить") {
                                authVM.signOut()
                            }
                        }
                        
                        Button("Выйти") {
                            authVM.signOut()
                        }
                    }
                }
                
                Section {
                    NavigationLink("Уведомления и звуки") {
                        
                    }
                    
                    NavigationLink("Данные и память") {
                        
                    }
                    
                    NavigationLink("Оформление") {
                        
                    }
                    
                    Picker("Язык", selection: $languagePicker) {
                        ForEach(LanguageSelectionPreferenceEnum.allCases, id: \.self) { item in
                            Text(item.rawValue)
                        }
                    }
                }
                
//                Section {
//                    NavigationLink("Баланс и денежные переводы") {
//                        
//                    }
//                }
                
                Section {
                    NavigationLink("Условия и Политика конфеденциальности") {
                        
                    }
                }
            }
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
