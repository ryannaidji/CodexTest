import WidgetKit
import SwiftUI
import SharedConstants

struct LockScreenEntry: TimelineEntry {
    let date: Date
    let message: String

    var circularDisplayText: String {
        let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return "SLW" }

        let words = trimmed.split(separator: " ").prefix(3)
        let initials = words.compactMap { $0.first }.map(String.init).joined()
        if initials.isEmpty {
            return String(trimmed.prefix(3)).uppercased()
        }

        return initials.uppercased()
    }
}

struct LockScreenProvider: TimelineProvider {
    func placeholder(in context: Context) -> LockScreenEntry {
        LockScreenEntry(date: Date(), message: SharedConstants.defaultMessage)
    }

    func getSnapshot(in context: Context, completion: @escaping (LockScreenEntry) -> Void) {
        completion(makeEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<LockScreenEntry>) -> Void) {
        let entry = makeEntry()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) ?? Date().addingTimeInterval(900)
        completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
    }

    private func makeEntry() -> LockScreenEntry {
        let defaults = UserDefaults(suiteName: SharedConstants.appGroupIdentifier)
        let storedMessage = defaults?.string(forKey: SharedConstants.widgetMessageKey) ?? SharedConstants.defaultMessage
        let finalMessage = storedMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        return LockScreenEntry(date: Date(), message: finalMessage.isEmpty ? SharedConstants.defaultMessage : finalMessage)
    }
}

struct LockScreenWidgetEntryView: View {
    var entry: LockScreenProvider.Entry
    @Environment(\.widgetFamily) private var family

    var body: some View {
        switch family {
        case .accessoryCircular:
            ZStack {
                AccessoryWidgetBackground()
                Text(entry.circularDisplayText)
                    .font(.system(.title3, design: .rounded))
                    .minimumScaleFactor(0.5)
            }
        case .accessoryInline:
            Text(entry.message)
        case .accessoryRectangular:
            VStack(spacing: 6) {
                Text(entry.message)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.6)
                Text("SimpleLockWidget")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        @unknown default:
            Text(entry.message)
        }
    }
}

struct LockScreenWidget: Widget {
    let kind: String = SharedConstants.widgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LockScreenProvider()) { entry in
            LockScreenWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Texte personnalisé")
        .description("Affiche votre texte dans l'écran verrouillé.")
        .supportedFamilies([.accessoryCircular, .accessoryInline, .accessoryRectangular])
    }
}

#Preview(as: .accessoryRectangular, widget: LockScreenWidget()) {
    LockScreenEntry(date: .now, message: "Un exemple de message")
}

#Preview(as: .accessoryInline, widget: LockScreenWidget()) {
    LockScreenEntry(date: .now, message: "Inline preview")
}

#Preview(as: .accessoryCircular, widget: LockScreenWidget()) {
    LockScreenEntry(date: .now, message: "Bonjour")
}
