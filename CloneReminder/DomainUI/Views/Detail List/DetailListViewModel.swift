import Combine
import Foundation

protocol DetailListViewModelInterface: ObservableObject {
    var itemsList: ItemsList { get set }
    
    func tappedNewItem()
    func tappedOnDetail(of item: Item)
    func toogle(item: Item)
    func submit(on item: Item)
    func traillingSwapped(on item: Item)
    func leadingSwapped(on item: Item)
}

final class DetailListViewModel: DetailListViewModelInterface {
    
    @Published
    var itemsList: ItemsList
    
    private var coordinator: any CoordinatorInterface
    private var dataService: DataServiceInterface
    
    init(coordinator: some CoordinatorInterface ,dataService: DataServiceInterface, itemsList: ItemsList) {
        self.itemsList = itemsList
        self.dataService = dataService
        self.coordinator = coordinator
    }
    
    func tappedNewItem() {
        let item = Item(name: "New Item", isCompleted: false, list: itemsList)
        itemsList.items.append(item)
        save(on: item)
        save(on: itemsList)
    }
    
    func tappedOnDetail(of item: Item) {
        coordinator.present(.itemDetail(item: item))
    }
    
    func toogle(item: Item) {
        item.isCompleted.toggle()
        save(on: item)
    }
    
    func submit(on item: Item) {
        save(on: item)
    }
    
    func traillingSwapped(on item: Item) {
        delete(on: item)
    }
    
    func leadingSwapped(on item: Item) {
        item.isCompleted.toggle()
        save(on: item)
    }
}

private extension DetailListViewModel {
    func save(on item: Item) {
        do {
            try dataService.save(item)
        } catch {
            Logger.error(error.localizedDescription)
        }
    }
    
    func save(on list: ItemsList) {
        do {
            try dataService.save(list)
        } catch {
            Logger.error(error.localizedDescription)
        }
    }
    
    func delete(on item: Item) {
        do {
            try dataService.delete(item)
        } catch {
            Logger.error(error.localizedDescription)
        }
    }
}

extension DetailListViewModel {
    static var mock: Self {
        .init(
            coordinator: MockCoordinator(),
            dataService: DataService.mock,
            itemsList: .mock,
        )
    }
}
