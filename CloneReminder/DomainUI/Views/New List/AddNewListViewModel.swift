import Combine
import SwiftData
import SwiftUI

protocol AddNewListViewModelInterface: ObservableObject {
    var listIconName: String { get set }
    var listName: String { get set }
    var color: Color { get set }
    
    func cancel()
    func save()
}


final class AddNewListViewModel: AddNewListViewModelInterface {
    var coordinator: any CoordinatorInterface
    var dataService: DataServiceInterface
    @Published
    var listIconName: String
    @Published
    var listName: String
    @Published
    var color: Color
    
    init(coordinator: some CoordinatorInterface, dataService: DataServiceInterface) {
        self.coordinator = coordinator
        self.dataService = dataService
        self.listIconName = "line.3.horizontal.circle.fill"
        self.listName = ""
        self.color = .cyan
    }
    
    func cancel() {
        coordinator.dismiss()
    }
    
    func save() {
        let newList = ItemsList(
            iconName: listIconName,
            name: listName,
            colorHex: color.toHexString() ?? "#F0F0F0"
        )
        
        do {
            try dataService.save(newList)
            coordinator.dismiss()
        } catch {
            debugPrint(error)
        }
    }
}

#if DEBUG
extension AddNewListViewModel {
    static var mock: AddNewListViewModel {
        let viewModel = AddNewListViewModel(
            coordinator: MockCoordinator(),
            dataService: DataService.mock
        )
        
        viewModel.listIconName = "line.3.horizontal.circle.fill"
        viewModel.listName = "My Car List"
        viewModel.color = .blue
        
        return viewModel
    }
}
#endif
