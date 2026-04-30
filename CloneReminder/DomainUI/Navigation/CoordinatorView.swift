import SwiftData
import SwiftUI

struct CoordinatorView<CoordinatorProtocol: CoordinatorInterface>: View {
    @StateObject private var coordinator: CoordinatorProtocol
    
    private let startRoute: NavigationRouteScreens
    private var dataService: DataServiceInterface
    
    init(coordinator: CoordinatorProtocol, startRoute: NavigationRouteScreens, dataService: DataServiceInterface) {
        _coordinator = StateObject(wrappedValue: coordinator)
        self.startRoute = startRoute
        self.dataService = dataService
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            build(
                route: self.startRoute,
                withCoordinator: coordinator
            )
                .navigationDestination(for: NavigationRouteScreens.self) { route in
                    build(
                        route: route,
                        withCoordinator: coordinator
                    )
                }
                .sheet(item: $coordinator.presentingSheet) { sheet in
                    build(
                        sheet: sheet,
                        withCoordinator: coordinator
                    )
                }
        }
    }
    
    @ViewBuilder
    func build(route: NavigationRouteScreens, withCoordinator coordinator: any CoordinatorInterface) -> some View {
        switch route {
        case .lists:
            ListsBuilder.build(coordinator: coordinator, dataService: dataService)
        case .detail(let itemsList):
            DetailListBuilder.build(itemsList: itemsList, dataService: dataService)
        }
    }
    
    @ViewBuilder
    func build(sheet: SheetsScreens, withCoordinator coordinator: any CoordinatorInterface) -> some View {
        switch sheet {
        case .createList:
            NavigationStack {
                AddNewListViewBuilder.build(coordinator: coordinator, dataService: dataService)
            }
        }
    }
}

#Preview {
    CoordinatorView(
        coordinator: MockCoordinator(),
        startRoute: .lists,
        dataService: DataService.mock
    )
}
