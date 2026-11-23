import SwiftUI
import AVFoundation

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage(PlaybackSettings.rateKey) private var rate = PlaybackSettings.defaultRate
    @AppStorage(PlaybackSettings.voiceKey) private var voiceIdentifier = ""

    @State private var voices: [AVSpeechSynthesisVoice] = []

    var body: some View {
        NavigationStack {
            Form {
                Section("Velocidad") {
                    Picker("Velocidad", selection: $rate) {
                        ForEach(PlaybackSettings.rates, id: \.self) { value in
                            Text(PlaybackSettings.label(for: value)).tag(value)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section {
                    Picker("Voz", selection: $voiceIdentifier) {
                        Text("Automática (idioma del sistema)").tag("")
                        ForEach(voices, id: \.identifier) { voice in
                            Text(voiceLabel(voice)).tag(voice.identifier)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Voz")
                } footer: {
                    Text("Podés descargar voces de mejor calidad en Ajustes › Accesibilidad › Contenido leído › Voces.")
                }
            }
            .navigationTitle("Voz y velocidad")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Listo") { dismiss() }
                }
            }
            .onAppear(perform: loadVoices)
        }
    }

    private func loadVoices() {
        let preferred = ["es", "en"]
        voices = AVSpeechSynthesisVoice.speechVoices()
            .filter { voice in preferred.contains { voice.language.hasPrefix($0) } }
            .sorted { ($0.language, $0.name) < ($1.language, $1.name) }
    }

    private func voiceLabel(_ voice: AVSpeechSynthesisVoice) -> String {
        let language = Locale.current.localizedString(forIdentifier: voice.language) ?? voice.language
        let quality: String
        switch voice.quality {
        case .premium: quality = " · Premium"
        case .enhanced: quality = " · Mejorada"
        default: quality = ""
        }
        return "\(voice.name) — \(language)\(quality)"
    }
}

#Preview {
    SettingsView()
}
