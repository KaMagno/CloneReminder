import Foundation

enum DetailListBuilder {
    static func build(coordinator: some CoordinatorInterface, dataService: DataServiceInterface, itemsList: ItemsList) -> DetailListView<DetailListViewModel> {
        let viewModel = DetailListViewModel(
            coordinator: coordinator,
            dataService: dataService,
            itemsList: itemsList
        )
        return DetailListView(viewModel: viewModel)
    }
}
