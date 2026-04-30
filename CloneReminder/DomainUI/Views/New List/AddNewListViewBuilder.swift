import SwiftUI

enum AddNewListViewBuilder {
    static func build(coordinator: any CoordinatorInterface, dataService: DataServiceInterface) -> AddNewListView<AddNewListViewModel> {
        let viewModel = AddNewListViewModel(coordinator: coordinator, dataService: dataService)
        let view = AddNewListView(model: viewModel)
        
        return view
    }
}
