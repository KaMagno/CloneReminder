import Foundation

@inlinable
func coping<T>(_ object: T, _ doChanges: ((inout T) -> Void) ) -> T {
    var copiedObject = object
    doChanges(&copiedObject)
    return copiedObject
}
