//
//  SwiftDataPractiseApp.swift
//  SwiftDataPractise
//
//  Created by Göksu Bayram on 30.07.2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataPractiseApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Todo.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Todo.self, isAutosaveEnabled: true)
    }
}
