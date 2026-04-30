import Foundation


enum ListsBuilder {
    static func build(coordinator: any CoordinatorInterface, dataService: DataServiceInterface) -> ListsView<ListViewModel> {
        let viewModel = ListViewModel(coordinator: coordinator, dataService: dataService)
        let view = ListsView(model: viewModel)
        return view
    }
}
