//import Combine
//import SwiftUI
//
//enum NavigationRouteScreens: Hashable {
//    case lists
////    case listDetail(list: ItemsList)
//    case createList
////    case createItem
////    case itemDetail(item: Item)
//}
//
////enum SheetsScreens: String, Identifiable {
////
////}
//
////enum AppFullScreenCovers: String, Identifiable {
////
////}
//
//final class Coordinator: ObservableObject {
//    @Published
//    var path: NavigationPath
//    
////    @Published
////    var presentingSheet: SheetsScreens?
//    
////    @Published
////    var presentingFullScreenCover: AppFullScreenCovers?
//    
//    init(path: NavigationPath = NavigationPath()) {
//        self.path = path
//    }
//    
//    // MARK: - Methods
//    
//    func push(to route: NavigationRouteScreens) {
//        path.append(route)
//    }
//    
//    func popToRoot() {
//        path.removeLast(path.count)
//    }
//    
////    func present(sheet: SheetsScreens) {
////        self.presentingSheet = sheet
////    }
//    
////    func present(fullScreenCover: AppFullScreenCovers) {
////        self.presentingFullScreenCover = fullScreenCover
////    }
//    
////    func dismissSheet() {
////        self.presentingSheet = nil
////    }
//    
////    func dismissCover() {
////        self.presentingFullScreenCover = nil
////    }
//    
//    // MARK: - Builders
//    
//    @ViewBuilder
//    func build(route: NavigationRouteScreens) -> some View {
//        switch route {
//        case .lists: ListsBuilder.build()
//        case .createList: AddNewListViewBuilder.build()
//        }
//    }
//    
////    @ViewBuilder
////        func build(sheet: SheetsScreens) -> some View {
////            switch sheet {
////            //
////            }
////        }
//        
////    @ViewBuilder
////    func build(cover: AppFullScreenCovers) -> some View {
////        switch cover {
////            //
////        }
////    }
//}
//
//struct CoordinatorView: View {
//    @StateObject private var coordinator = Coordinator()
//    
//    var body: some View {
//        NavigationStack(path: $coordinator.path) {
//            coordinator.build(route: .createList)
//                .navigationDestination(for: NavigationRouteScreens.self) { route in
//                    coordinator.build(route: route)
//                }
////                .sheet(item: $coordinator.presentingSheet) { sheet in
////                    coordinator.build(sheet: sheet)
////                }
////                .fullScreenCover(item: $coordinator.presentingFullScreen) { fullScreenCover in
////                    coordinator.build(cover: fullScreenCover)
////                }
//        }
//        .environmentObject(coordinator)
//    }
//}
