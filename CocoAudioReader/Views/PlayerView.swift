import SwiftUI

struct PlayerView: View {
    let document: LibraryDocument

    // Etapa 1: estado visual solamente. La lectura real llega en las Etapas 3 y 4.
    @State private var isPlaying = false
    @State private var pageIndex: Int
    @State private var showingSettings = false
    @AppStorage(PlaybackSettings.rateKey) private var rate = PlaybackSettings.defaultRate

    init(document: LibraryDocument) {
        self.document = document
        _pageIndex = State(initialValue: document.lastPageIndex)
    }

    var body: some View {
        VStack(spacing: 28) {
            Spacer(minLength: 0)

            cover

            VStack(spacing: 6) {
                Text(document.title)
                    .font(.title2.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                Text("Página \(pageIndex + 1) de \(document.pageCount)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            .padding(.horizontal)

            ProgressView(value: Double(pageIndex + 1), total: Double(max(document.pageCount, 1)))
                .tint(.accentColor)
                .padding(.horizontal, 32)
                .accessibilityLabel("Progreso")

            controls

            Button {
                showingSettings = true
            } label: {
                Label("Velocidad \(PlaybackSettings.label(for: rate))", systemImage: "speedometer")
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(.thinMaterial, in: Capsule())
            }

            Spacer(minLength: 0)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }

    private var cover: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(
                LinearGradient(colors: [Color.accentColor.opacity(0.85), Color.accentColor.opacity(0.45)],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .frame(width: 220, height: 220)
            .overlay(
                Image(systemName: "headphones")
                    .font(.system(size: 72, weight: .light))
                    .foregroundStyle(.white)
            )
            .shadow(color: .black.opacity(0.15), radius: 16, y: 8)
            .accessibilityHidden(true)
    }

    private var controls: some View {
        HStack(spacing: 44) {
            Button {
                pageIndex = max(pageIndex - 1, 0)
            } label: {
                Image(systemName: "backward.fill")
                    .font(.system(size: 34))
            }
            .accessibilityLabel("Retroceder")

            Button {
                isPlaying.toggle()
            } label: {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 88))
                    .symbolRenderingMode(.hierarchical)
            }
            .accessibilityLabel(isPlaying ? "Pausa" : "Reproducir")

            Button {
                pageIndex = min(pageIndex + 1, document.pageCount - 1)
            } label: {
                Image(systemName: "forward.fill")
                    .font(.system(size: 34))
            }
            .accessibilityLabel("Avanzar")
        }
        .foregroundStyle(Color.accentColor)
    }
}

#Preview {
    NavigationStack {
        PlayerView(document: LibraryDocument.samples[0])
    }
}
