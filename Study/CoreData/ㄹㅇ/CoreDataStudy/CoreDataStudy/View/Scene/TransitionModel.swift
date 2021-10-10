import Foundation

enum TransitionStyle {
    case root
    case push
}

enum TransitionError: Error {
    case NavigationControllerMissing
    case cannotPopViewController
    case unknown
}
