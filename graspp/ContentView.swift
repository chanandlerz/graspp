//
//  ContentView.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("My Shelf", systemImage: "books.vertical", value: 0) {
                HomeScreen()
            }
            Tab("Category", systemImage: "rectangle.grid.2x2", value: 1) {
                CategoryScreen()
            }
            
            Tab(value: 2, role: .search) {
                SearchScreen()
            }
        }
    }  
}

#Preview {
    ContentView()
}
