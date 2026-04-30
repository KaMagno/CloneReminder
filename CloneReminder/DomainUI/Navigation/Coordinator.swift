import Combine
import SwiftUI

protocol CoordinatorInterface: ObservableObject {
    var path: NavigationPath { get set }
    var presentingSheet: SheetsScreens? { get set }
    
    func push(to route: NavigationRouteScreens)
    func popToRoot()
    func pop()
    
    func present(_ sheet: SheetsScreens)
    func dismiss()
}

final class Coordinator: CoordinatorInterface {
    @Published
    var path: NavigationPath
    
    @Published
    var presentingSheet: SheetsScreens?
    
    init(path: NavigationPath = NavigationPath()) {
        self.path = path
    }
    
    init(startRoute: NavigationRouteScreens) {
        self.path = NavigationPath()
        self.path.append(startRoute)
    }
    
    // MARK: - Methods
    
    // MARK: Navigation
    
    func push(to route: NavigationRouteScreens) {
        path.append(route)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func pop() {
        path.removeLast()
    }
    
    // MARK: Present
    
    func present(_ sheet: SheetsScreens) {
        self.presentingSheet = sheet
    }
    
    func dismiss() {
        self.presentingSheet = nil
    }
}



