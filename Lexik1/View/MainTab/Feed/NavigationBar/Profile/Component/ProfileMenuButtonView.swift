//
//  ProfileMenuButtonView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 04.08.2023.
//

import SwiftUI

struct ProfileMenuButtonView: View {
    var body: some View {
        Menu {
            NavigationLink("Новый пост") {
                NewContentView()
            }
            
            NavigationLink("Профиль") {
                ProfileView()
            }
        } label: {
            Image(systemName: "person")
        }
    }
}

struct ProfileMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenuButtonView()
    }
}
