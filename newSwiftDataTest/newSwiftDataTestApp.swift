//
//  newSwiftDataTestApp.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2024/12/12.
//

import SwiftUI
import SwiftData

@main
struct newSwiftDataTestApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            ModelPlaylist.self,
            ModelMusicList.self
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
//            MusicControl()
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
