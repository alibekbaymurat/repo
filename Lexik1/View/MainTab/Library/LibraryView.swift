//
//  LibraryView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 31.07.2023.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        MainTabViewBuilder(title: "Библиотека") {
            Form {
                Section {
                    NavigationLink("Подписки") {
                        
                    }
                }
                
                Section {
                    NavigationLink("Понравившиеся посты") {
                        
                    }
                    
                    NavigationLink("Непонравившиеся посты") {
                        
                    }
                }
                
                Section {
                    NavigationLink("Комментируемые посты") {
                        
                    }
                }
                
                Section {
                    NavigationLink("Сохраненные посты") {
                        
                    }
                }
                
                Section {
                    NavigationLink("Посты с закладками") {
                        
                    }
                }
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
