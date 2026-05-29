import Foundation

enum NavigationRouteScreens: Hashable {
    case lists
    case listDetail(list: ItemsList)
}
