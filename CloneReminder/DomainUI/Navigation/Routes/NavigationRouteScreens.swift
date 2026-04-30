import Foundation

enum NavigationRouteScreens: Hashable {
    case lists
    case detail(list: ItemsList)
}
