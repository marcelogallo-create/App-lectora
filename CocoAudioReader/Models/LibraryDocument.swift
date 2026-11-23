import Foundation

/// Un documento PDF de la biblioteca local.
struct LibraryDocument: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var fileName: String
    var pageCount: Int
    /// Última página escuchada (base 0).
    var lastPageIndex: Int
    var dateAdded: Date

    init(id: UUID = UUID(),
         title: String,
         fileName: String,
         pageCount: Int,
         lastPageIndex: Int = 0,
         dateAdded: Date = .now) {
        self.id = id
        self.title = title
        self.fileName = fileName
        self.pageCount = pageCount
        self.lastPageIndex = lastPageIndex
        self.dateAdded = dateAdded
    }

    var progress: Double {
        guard pageCount > 0 else { return 0 }
        return Double(lastPageIndex + 1) / Double(pageCount)
    }
}

extension LibraryDocument {
    /// Datos de ejemplo solo para la Etapa 1 (se eliminan al implementar la importación).
    static let samples: [LibraryDocument] = [
        LibraryDocument(title: "Terapia de Aceptación y Compromiso", fileName: "act.pdf",
                        pageCount: 148, lastPageIndex: 37),
        LibraryDocument(title: "Neurociencia cognitiva — Capítulo 4", fileName: "neuro.pdf",
                        pageCount: 42, lastPageIndex: 0)
    ]
}
