import SwiftUI

struct LibraryView: View {
    // Etapa 1: datos de ejemplo. En la Etapa 2 se reemplaza por la biblioteca real.
    @State private var documents: [LibraryDocument] = LibraryDocument.samples
    @State private var showingSettings = false

    var body: some View {
        NavigationStack {
            Group {
                if documents.isEmpty {
                    emptyState
                } else {
                    list
                }
            }
            .navigationTitle("Biblioteca")
            .navigationDestination(for: LibraryDocument.self) { doc in
                PlayerView(document: doc)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { showingSettings = true } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .accessibilityLabel("Ajustes de voz y velocidad")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Etapa 2: abrir el selector de archivos.
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Importar PDF")
                    .disabled(true)
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }

    private var list: some View {
        List {
            ForEach(documents) { doc in
                NavigationLink(value: doc) {
                    DocumentRow(document: doc)
                }
            }
            .onDelete { documents.remove(atOffsets: $0) }
        }
        .listStyle(.insetGrouped)
    }

    private var emptyState: some View {
        ContentUnavailableView {
            Label("Tu biblioteca está vacía", systemImage: "books.vertical")
        } description: {
            Text("Importá un PDF para empezar a escucharlo.")
        }
    }
}

struct DocumentRow: View {
    let document: LibraryDocument

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.accentColor.opacity(0.15))
                .frame(width: 48, height: 64)
                .overlay(
                    Image(systemName: "doc.text")
                        .font(.title2)
                        .foregroundStyle(Color.accentColor)
                )
            VStack(alignment: .leading, spacing: 6) {
                Text(document.title)
                    .font(.headline)
                    .lineLimit(2)
                Text("PDF · \(document.pageCount) páginas")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                if document.lastPageIndex > 0 {
                    ProgressView(value: document.progress)
                        .tint(.accentColor)
                    Text("Última posición: página \(document.lastPageIndex + 1)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 6)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    LibraryView()
}
