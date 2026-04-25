import SwiftUI
import Combine

final class MockCoordinator: CoordinatorInterface, ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var presentingSheet: SheetsScreens?
    
    var pushedRoutes: [NavigationRouteScreens] = []
    var popToRootCalled = false
    var popCalled = false
    
    func push(to route: NavigationRouteScreens) {
        pushedRoutes.append(route)
        path.append(route)
    }
    func popToRoot() {
        popToRootCalled = true
        path = NavigationPath()
    }
    func pop() {
        popCalled = true
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func present(_ sheet: SheetsScreens) {
        presentingSheet = sheet
    }
    func dismiss() {
        self.presentingSheet = nil
    }
}

#Preview {
    CoordinatorView(coordinator: MockCoordinator(), startRoute: .lists, dataService: DataService.mock)
}
