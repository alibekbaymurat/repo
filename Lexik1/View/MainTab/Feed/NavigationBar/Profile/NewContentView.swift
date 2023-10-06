//
//  NewContentView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 04.08.2023.
//

import SwiftUI

struct NewContentView: View {
    var body: some View {
        MainTabViewBuilder(title: "Новый пост") {
            Form {
                NavigationLink("Создать новый пост") {
                    NewContentCreaterView(initialCaption: "")
                }
                
                Section("Черновики") {
                    ForEach(1...9, id: \.self) { _ in
                        NavigationLink {
                            
                        } label: {
                            Text("Как выжить в эсктримальных условиях в Северном Казахстане и не умереть с голоду?")
                                .lineLimit(2)
                        }
                    }
                }
            }
        }
    }
}

struct NewContentCreaterView: View {
    @State private var caption = ""
    init(initialCaption: String) {
        _caption = State(initialValue: initialCaption)
    }
    var body: some View{
        VStack {
            TextEditor(text: $caption)
                .padding()
                .autocorrectionDisabled()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Text("Выложить")
                }
            }
        }
    }
}


struct NewContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewContentView()
    }
}
