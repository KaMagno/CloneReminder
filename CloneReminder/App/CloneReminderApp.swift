//
//  CloneReminderApp.swift
//  CloneReminder
//
//  Created by Kaique Magno on 22/04/26.
//

import SwiftUI
import SwiftData

@main
struct CloneReminderApp: App {
    var dataService: DataServiceInterface = {
        let schema = Schema([
            Item.self,
            ItemsList.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            var sharedModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            return DataService(modelContainer: sharedModelContainer)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CoordinatorView(
                coordinator: Coordinator(startRoute: .lists),
                startRoute: .lists,
                dataService: dataService
            )
        }
    }
}
