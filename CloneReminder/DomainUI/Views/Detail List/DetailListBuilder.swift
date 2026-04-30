import Foundation

enum DetailListBuilder {
    static func build(itemsList: ItemsList, dataService: DataServiceInterface) -> DetailListView<DetailListViewModel> {
        let viewModel = DetailListViewModel(itemsList: itemsList, dataService: dataService)
        return DetailListView(viewModel: viewModel)
    }
}
