import Foundation

enum NavigationRouteScreens: Hashable {
    case lists
    case listDetail(list: ItemsList)
    case itemDetail(item: Item)
}
