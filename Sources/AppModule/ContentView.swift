import SwiftUI
import WidgetKit
import SharedConstants

struct ContentView: View {
    @Binding var message: String
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section("Texte du widget") {
                    TextField("Message", text: $message, axis: .vertical)
                        .focused($isTextFieldFocused)
                        .lineLimit(3, reservesSpace: true)
                        .onSubmit { isTextFieldFocused = false }
                    Text("Le texte ci-dessus sera partagé avec le widget de l'écran verrouillé.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Section("Aperçu rapide") {
                    LockScreenPreview(message: message)
                        .padding(.vertical, 4)
                }

                Section {
                    Button {
                        WidgetCenter.shared.reloadTimelines(ofKind: SharedConstants.widgetKind)
                    } label: {
                        Label("Forcer la mise à jour du widget", systemImage: "arrow.clockwise")
                    }
                } footer: {
                    Text("Les widgets se mettent normalement à jour quelques instants après une modification. Utilisez ce bouton pour demander une actualisation immédiate.")
                }
            }
            .navigationTitle("SimpleLockWidget")
        }
        .onChange(of: message) { _ in
            WidgetCenter.shared.reloadTimelines(ofKind: SharedConstants.widgetKind)
        }
    }
}

private struct LockScreenPreview: View {
    var message: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Group {
                Text("Inline")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(message)
                    .font(.callout)
            }

            Divider()

            Group {
                Text("Rectangulaire")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                    Text(message)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .frame(height: 96)
            }
        }
    }
}

#Preview {
    ContentView(message: .constant(SharedConstants.defaultMessage))
}
