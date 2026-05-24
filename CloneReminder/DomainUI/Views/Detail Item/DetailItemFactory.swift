import Foundation

enum DetailItemFactory {
    static func build(
        coordinator: any CoordinatorInterface,
        dataService: DataServiceInterface,
        item: Item
    ) -> DetailItemView<DetailItemViewModel> {
        
        let viewModel = DetailItemViewModel(
            item: item,
            dataService: dataService,
            coordinator: coordinator
        )
        return DetailItemView(viewModel: viewModel)
    }
}

