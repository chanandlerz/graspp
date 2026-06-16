//
//  grasppApp.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 13/06/26.
//

import SwiftUI
import SwiftData

@main
struct grasppApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for:
                                            ArticleCategory.self,
                                           Article.self,
                                           CodeSnippet.self,
                                           ArticleReference.self
                                           
            )
            
            let context = container.mainContext
            
            if !UserDefaults.standard.bool(forKey: "graspp.seeded") {
                SeedData.insert(into: context)
                UserDefaults.standard.set(true, forKey: "graspp.seeded")
            }
        } catch {
            fatalError("SwiftData failed to initialize: \(error)")
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
}
