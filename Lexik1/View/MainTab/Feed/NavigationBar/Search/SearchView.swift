//
//  SearchView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 04.08.2023.
//

import SwiftUI

struct SearchView: View {
    @State private var textFieldText = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        MainTabViewBuilder(title: "") {
            ContentScrollViewBuilder(content: {
                ContentCellPatternView(contentType: .all, isRepost: false)
            })
//            List {
//                ForEach(1...10, id: \.self) { _ in
//                    HStack {
//                        Image(systemName: "clock.arrow.circlepath")
//
//                        Text("Everything will be allright")
//                            .lineLimit(1)
//
//                        Spacer()
//
//                        Button {
//
//                        } label: {
//                            Image(systemName: "arrow.up.left")
//                        }
//                    }
//                }
//            }
//            .listStyle(.plain)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
                
                ToolbarItem(placement: .automatic){
                    TextField("Что ищете?", text: $textFieldText)
                        .autocorrectionDisabled()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: UIScreen.main.bounds.width * 0.85)
                        .submitLabel(.search)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
