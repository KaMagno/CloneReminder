import SwiftUI
import Combine

private enum ListsViewConstants {
    enum ButtonSize {
        static let width: CGFloat = 42
        static let height: CGFloat = 42
    }
}

struct ListsView<ViewModel: ListViewModelInterface>: View {
    
    @ObservedObject
    private var model: ViewModel
    
    var body: some View {
        switch model.viewStates {
        case .empty:
            buildViewEmpty()
        case .loading:
            buildViewLoading()
        case .error:
            buildViewError()
        case .idle(let itemsLists):
            buildViewIdle(itemsLists: itemsLists)
        }
    }
    
    init(model: ViewModel) {
        self.model = model
    }
}

private extension ListsView {
    
    @ViewBuilder
    func buildViewEmpty() -> some View {
        VStack {
            Image(systemName: "questionmark")
                .foregroundStyle(Color.red)
            Text("No data")
        }
        .task {
            model.fetchData()
        }
    }
    
    @ViewBuilder
    func buildViewLoading() -> some View {
        VStack {
            ProgressView()
        }
    }
    
    @ViewBuilder
    func buildViewError() -> some View {
        VStack {
            Image(systemName: "exclamation")
                .foregroundStyle(Color.red)
            
            Text("Could not load data")
            
            Button {
                model.fetchData()
            } label: {
                Text("Try again")
            }
            .buttonStyle(.bordered)

        }
    }
    
    @ViewBuilder
    func buildViewIdle(itemsLists: [ItemsList]) -> some View {
        VStack {
            HStack {
                Text("My Lists")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding()
            
            List(itemsLists) { list in
                ListRowView(list: list)
                    .onTapGesture {
                        model.goTo(list: list)
                    }
            }
            .listStyle(.inset)
            
            Button {
                model.goToNewList()
            } label: {
                ZStack {
                    Circle()
                        .foregroundStyle(Color.black.opacity(0.1))
                        .frame(width: ListsViewConstants.ButtonSize.width, height: ListsViewConstants.ButtonSize.height)
                    Image(systemName: "plus")
                }
                .frame(maxWidth: .infinity, maxHeight: ListsViewConstants.ButtonSize.height, alignment: .trailing)
            }
            .padding(.trailing, 16)
            .padding(.bottom, 16)

        }
    }
}

#Preview {
    ListsView(model: ListViewModel.mock)
}
