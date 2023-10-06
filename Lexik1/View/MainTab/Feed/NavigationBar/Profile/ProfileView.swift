//
//  ProfileView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 04.08.2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        MainTabViewBuilder(title: "Профиль") {
            ContentCellPatternView(contentType: .profile, isRepost: false)
            
            ContentScrollViewBuilder {
                ContentCellPatternView(contentType: .all, isRepost: false)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
