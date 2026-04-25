import Combine

protocol ListViewModelInterface: ObservableObject {
    var viewStates: ListViewStates { get }
    
    func fetchData()
    func goToNewList()
}

enum ListViewStates {
    case empty
    case loading
    case error
    case idle(itemsLists: [ItemsList])
}

final class ListViewModel: ListViewModelInterface {
    var coordinator: any CoordinatorInterface
    var dataService: DataServiceInterface
    
    @Published
    var viewStates: ListViewStates
    
    init(coordinator: some CoordinatorInterface, dataService: DataServiceInterface) {
        self.coordinator = coordinator
        self.dataService = dataService
        viewStates = .empty
    }
    
    func fetchData() {
        do {
            viewStates = .loading
            let itemsList: [ItemsList] = try dataService.fetch()
            viewStates = .idle(itemsLists: itemsList)
        } catch {
            debugPrint(error)
            viewStates = .error
        }
    }
    
    func goToNewList() {
        coordinator.present(.createList)
    }
}

#if DEBUG
extension ListViewModel {
    static var mock: Self {
        .init(coordinator: MockCoordinator(), dataService: DataService.mock)
    }
}
#endif
