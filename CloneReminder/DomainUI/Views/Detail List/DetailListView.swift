import SwiftUI

struct DetailListView<ViewModel: DetailListViewModelInterface>: View {
    
    @ObservedObject
    private var model: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: model.itemsList.iconName)
                    .font(.largeTitle)
                    .foregroundStyle(Color(hex: model.itemsList.colorHex)!)
                Text(model.itemsList.name)
                    .font(.largeTitle)
                    .foregroundStyle(Color(hex: model.itemsList.colorHex)!)
                Spacer()
            }
            .padding()
            
            List() {
                ForEach(model.itemsList.items)  { item in
                    ItemRowView(item, color: .init(hex: model.itemsList.colorHex)!)
                        .onSubmit {
                            model.submit(on: item)
                        }
                        .onTapGesture {
                            model.tapped(on: item)
                        }
                }
                
                Button {
                    model.tappedNewItem()
                } label: {
                    Text("Add new item")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(.borderless)
            }
            .listStyle(.plain)
            .padding()
            
            Spacer()
        }
        .navigationTitle(model.itemsList.name)
    }
    
    init(viewModel: ViewModel) {
        self.model = viewModel
    }
}

#Preview {
    DetailListView(
        viewModel: DetailListViewModel.mock
    )
}
