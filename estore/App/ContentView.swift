//
//  ContentView.swift
//  estore
//
//  Created by Nadia Lovely on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Search()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            Users()
                .tabItem {
                    Label("Users", systemImage: "person.3.fill")
                }
        }
        .tint(.red)
    }
}

#Preview {
    ContentView()
}
