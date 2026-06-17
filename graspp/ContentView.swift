//
//  ContentView.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView (selection: $selectedTab){
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            CategoryScreen()
                .tabItem {
                    Label("Category", systemImage: "rectangle.grid.2x2")
                }
            
            SearchScreen()
                .tabItem () {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
