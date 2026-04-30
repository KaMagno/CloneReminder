import Combine
import Foundation

protocol ListViewModelInterface: ObservableObject {
    var viewStates: ListViewStates { get }
    
    func fetchData()
    func delete(list: ItemsList)
    func goToNewList()
    func goTo(list: ItemsList)
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
            Logger.error(error.localizedDescription)
            viewStates = .error
        }
    }
    
    func delete(list: ItemsList) {
        do {
            try dataService.delete(list)
        } catch {
            Logger.error(error.localizedDescription)
        }
    }
    
    func goToNewList() {
        coordinator.present(.createList)
    }
    
    func goTo(list: ItemsList) {
        coordinator.push(
            to: .detail(list: list)
        )
    }
}

#if DEBUG
extension ListViewModel {
    static var mock: Self {
        .init(coordinator: MockCoordinator(), dataService: DataService.mock)
    }
}
#endif
