import SwiftUI
import SharedConstants

@main
struct SimpleLockWidgetApp: App {
    @AppStorage(SharedConstants.widgetMessageKey, store: UserDefaults(suiteName: SharedConstants.appGroupIdentifier))
    private var message = SharedConstants.defaultMessage

    var body: some Scene {
        WindowGroup {
            ContentView(message: $message)
        }
    }
}
