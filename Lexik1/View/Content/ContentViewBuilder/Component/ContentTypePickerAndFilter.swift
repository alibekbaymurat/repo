//
//  ContentTypePickerAndFilter.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 31.07.2023.
//

import SwiftUI

struct ContentTypePickerAndFilter: View {
    
    let isCommentSheet: Bool
    
    // переменная для вывода шита фильтрации контента
    @Binding var showFilterSheet: Bool
    
    // переменная для выбора типа контента
    @Binding var selectedContentType: ContentType
    
    var body: some View {
        HStack() {
            HStack {
                if !isCommentSheet {
                    Text("Тип контента:")
                    
                    // пикер для выбора типа контента
                    Picker("", selection: $selectedContentType) {
                        ForEach(ContentType.allCases.filter({$0 != .repost}), id: \.self) { item in
                            Text(item.rawValue)
                        }
                    }
                    .foregroundColor(.white)
                    .tint(Color(.systemGray2))
                } else {
                    Text("213 комментариев")
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // кнопка для вывода шита фильтрации контента
            Button("Фильтр") {
                showFilterSheet.toggle()
            }
            .foregroundColor(.white)
            .tint(Color(.systemGray2))
        }
        .buttonStyle(.borderedProminent)
    }
}

// перечисление типа контента
enum ContentType: String, CaseIterable {
    case all = "Все",
         comment = "Комментарии",
         post = "Посты",
         profile = "Профили",
         repost = "Репосты"
}

// шит фильтрации контента
struct ContentFilterView: View {
    
    enum RatingFilter: String, CaseIterable {
        case relevant = "По релевантности",
             mostLiked = "Высокооцененные",
             mostUnderrated = "Низкооцененные"
    }

    enum DateOfAdditionFilter: String, CaseIterable {
        case relevant = "По релевантности",
             olderContent = "Новые",
             newerContent = "Старые"
    }

    enum CountryFilter: String, CaseIterable {
        case AllCountries = "Все страны",
             Kazakhstan = "Казахстан",
             Russia = "Россия",
             Ukraine = "Украина",
             Uzbekistan = "Узбекистан",
             Belarus = "Беларусь",
             Tadjikistan = "Таджикистан",
             Georgia = "Грузия",
             Azerbaijan = "Азербайджан",
             Lithuania = "Литва",
             Moldova = "Молдовия",
             Latvia = "Латвия",
             Kyrgyzstan = "Киргизстан",
             Armenia = "Армения",
             Estonia = "Эстония",
             Turkmenistan = "Туркменистан"
    }

    enum GenreType: String, CaseIterable {
        case allTypes = "Все",
             fantasy = "Фантастика",
             criminal = "Криминал",
             comedy = "Комедия",
             anime = "Аниме",
             sport = "Спорт",
             triller = "Триллер",
             western = "Вестерн",
             horror = "Ужас",
             mystery = "Мистика",
             science = "Научное"
    }
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedRating: RatingFilter = .relevant
    @State private var selectedDateOfAddition: DateOfAdditionFilter = .relevant
    @State private var selectedCountry: CountryFilter = .AllCountries
    @State private var selectedGenre: GenreType = .allTypes
    
    var body: some View {
        MainTabViewBuilder(title: "Фильтр") {
            Form {
                Section {
                    Picker("Жанр", selection: $selectedGenre) {
                        ForEach(GenreType.allCases, id: \.self) { item in
                            Text(item.rawValue)
                        }
                    }
                    
                    Picker("Страна", selection: $selectedCountry) {
                        ForEach(CountryFilter.allCases, id: \.self) { item in
                            Text(item.rawValue)
                        }
                    }
                }
                .pickerStyle(.navigationLink)
                
                Section("Сортировать по: ") {
                    Picker("Оценка", selection: $selectedRating) {
                        ForEach(RatingFilter.allCases, id: \.self) { item in
                            Text(item.rawValue)
                        }
                    }
                    
                    Picker("Дата публикации", selection: $selectedDateOfAddition) {
                        ForEach(DateOfAdditionFilter.allCases, id: \.self) { item in
                            Text(item.rawValue)
                        }
                    }
                }
                
                Button("Применить") {
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Закрыть") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.fraction(0.5)])
    }
}
