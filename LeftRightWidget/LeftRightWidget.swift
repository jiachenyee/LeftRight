//
//  LeftRightWidget.swift
//  LeftRightWidget
//
//  Created by Jia Chen Yee on 7/6/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct LeftRightWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var body: some View {
        
        if family == .accessoryCircular {
            #if os(iOS)
            HStack(spacing: 0) {
                ZStack {
                    Color.blue.opacity(0.2)
                    Text("L")
                }
                ZStack {
                    Color.clear
                    Text("R")
                }
            }
            .font(.subheadline)
            .ignoresSafeArea()
            #else
            ZStack {
                
                Text("L|R")
                    .kerning(4)
                    .font(.system(size: 17))
            }
            .ignoresSafeArea()
            #endif
        } else {
            HStack(spacing: 0) {
                ZStack {
                    Color.blue.opacity(0.2)
                    Text("Left")
                }
                ZStack {
                    Color.clear
                    Text("Right")
                }
            }
            .font(.title)
            .ignoresSafeArea()
        }
    }
}

@main
struct LeftRightWidget: Widget {
    let kind: String = "LeftRightWidget"

    #if os(iOS)
    let families: [WidgetFamily] = [.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge, .accessoryCircular, .accessoryInline]
    #else
    let families: [WidgetFamily] = [.accessoryCircular, .accessoryInline, .accessoryRectangular]
    #endif
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LeftRightWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Left Right")
        .description("Tell left from right apart on the home screen.")
        .supportedFamilies(families)
    }
}

struct LeftRightWidget_Previews: PreviewProvider {
    static var previews: some View {
        LeftRightWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
