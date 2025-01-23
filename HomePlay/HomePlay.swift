//
//  HomePlay.swift
//  HomePlay
//
//  Created by QIAEN on 2025/1/3.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let author: String
    let name: String
    let cover: String
    let isFavorite: Bool
}

let defaultMusic = SimpleEntry(date: Date(), author: "", name: "", cover: "avatar4", isFavorite: false)
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        print("---: placeholder")
        return SimpleEntry(date: Date(), author: "", name: "", cover: "avatar4", isFavorite: false)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        print("---: getSnapshot")
        let entry = SimpleEntry(date: Date(), author: "", name: "", cover: "avatar4", isFavorite: false)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print("---: getTimeline")
        let ud = UserDefaults(suiteName: "group.hongliang.liu.newSwiftDataTest")
        let name = ud?.string(forKey: "name") ?? "Music"
        let author = ud?.string(forKey: "author") ?? "Unknow"
        let isFavorite = ud?.bool(forKey: "isFavorite") ?? false
        
        let entry = SimpleEntry(date: Date(), author: author, name: name, cover: "avatar4", isFavorite: isFavorite)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}


struct HomePlayEntryView : View {
    var entry: Provider.Entry
    var body: some View {
        VStack {
            Image(entry.cover)
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
                .cornerRadius(6)
            Text("\(entry.author) - \(entry.name)")
                .padding(.vertical, 6)
            Image(systemName: entry.isFavorite ? "heart.fill" : "heart")
            
        }
    }
}

struct HomePlay: Widget {
    let kind: String = "HomePlay"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HomePlayEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    HomePlay()
} timeline: {
    SimpleEntry(date: .now, author: "", name: "", cover: "avatar4", isFavorite: false)
}
