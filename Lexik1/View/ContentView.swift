//
//  ContentView.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 30.07.2023.
//

import SwiftUI

extension UINavigationBar {
    static func changeAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel
    init() {
        UINavigationBar.changeAppearance()
    }
    var body: some View {
        Group {
            if authVM.userSession == nil {
                LoginView()
            } else {
                MainTabView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
