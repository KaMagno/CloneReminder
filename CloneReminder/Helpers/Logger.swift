import Foundation
import os

/// Lightweight logging utility with levels and categories.
/// Uses os.Logger on supported platforms and falls back to print otherwise.
enum Logger {
    enum Level: String {
        case debug = "DEBUG"
        case info = "INFO"
        case warning = "WARNING"
        case error = "ERROR"
    }

    /// Global toggle to mute logs in release if desired.
    /// In DEBUG builds, logging is enabled by default.
    static var isEnabled: Bool = {
        #if DEBUG
        return true
        #else
        return false // set to false to silence logs in Release
        #endif
    }()

    /// Default subsystem uses the app bundle identifier if available.
    private static var subsystem: String = Bundle.main.bundleIdentifier ?? "App"

    /// Cached os.Logger instances by category.
    private static var osLoggers: [String: os.Logger] = [:]

    private static func osLogger(for category: String) -> os.Logger {
        if let logger = osLoggers[category] { return logger }
        let logger = os.Logger(subsystem: subsystem, category: category)
        osLoggers[category] = logger
        return logger
    }

    // MARK: - Public API

    static func log(_ level: Level, _ message: @autoclosure () -> String, category: String = "General") {
        guard isEnabled else { return }
        let msg = message()
        #if canImport(os)
        let logger = osLogger(for: category)
        switch level {
        case .debug:
            logger.debug("\(msg)")
        case .info:
            logger.info("\(msg)")
        case .warning:
            logger.warning("\(msg)")
        case .error:
            logger.error("\(msg)")
        }
        #else
        print("[\(level.rawValue)] [\(category)] \(msg)")
        #endif
    }

    // Convenience helpers
    static func debug(_ message: @autoclosure () -> String, category: String = "General") {
        let baseMessage = "💬 "
        log(.debug, baseMessage+message(), category: category)
    }

    static func info(_ message: @autoclosure () -> String, category: String = "General") {
        let baseMessage = "❕ "
        log(.info, baseMessage+message(), category: category)
    }

    static func warning(_ message: @autoclosure () -> String, category: String = "General") {
        let baseMessage = "⚠️ "
        log(.warning, baseMessage+message(), category: category)
    }

    static func error(_ message: @autoclosure () -> String, category: String = "General") {
        let baseMessage = "❌ "
        log(.error, baseMessage+message(), category: category)
    }
}
