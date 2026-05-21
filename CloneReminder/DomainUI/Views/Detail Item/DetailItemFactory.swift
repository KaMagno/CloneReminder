import Foundation

enum DetailItemFactory {
    static func build(
        coordinator: any CoordinatorInterface,
        dataService: DataServiceInterface,
        items: Item
    ) -> DetailItemView<DetailItemViewModel> {
        
        let viewModel = DetailItemViewModel(
            item: items,
            dataService: dataService,
            coordinator: coordinator
        )
        return DetailItemView(viewModel: viewModel)
    }
}

