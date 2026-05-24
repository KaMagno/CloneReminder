import SwiftUI

extension Binding {
    /// Creates a non-optional Binding from an optional Binding by supplying a default value for nil.
    /// Writes are forwarded as non-optional values back into the optional source.
    init(_ source: Binding<Value?>, default defaultValue: @autoclosure @escaping () -> Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue() },
            set: { newValue in source.wrappedValue = newValue }
        )
    }
}
