import Foundation

/// Claves y valores por defecto de los ajustes de lectura.
enum PlaybackSettings {
    static let rateKey = "playback.rate"
    static let voiceKey = "playback.voiceIdentifier"

    static let defaultRate: Double = 1.0
    static let rates: [Double] = [0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.5]

    static func label(for rate: Double) -> String {
        rate == rate.rounded() ? String(format: "%.0f×", rate) : String(format: "%g×", rate)
    }
}
