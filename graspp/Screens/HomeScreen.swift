//
//  HomeScreen.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack{
            Text("Graspp")
                .font(Font.largeTitle.bold())
            
            FavoritesProgressive()
            Spacer()
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    HomeScreen()
}
