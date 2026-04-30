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
                        .listRowBackground(Color.white)
                        .onSubmit {
                            model.submit(on: item)
                        }
                        .onTapGesture {
                            model.tapped(on: item)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                model.traillingSwapped(on: item)
                            } label: {
                                Text("Delete")
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button(role: .close) {
                                model.leadingSwapped(on: item)
                            } label: {
                                Label("Check", systemImage: "checkmark")
                            }

                        }
                }
                
                Button {
                    model.tappedNewItem()
                } label: {
                    Text("Add new item")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(.borderless)
                .listRowSeparator(.hidden, edges: .bottom)
            }
            .padding()
            .listStyle(.plain)
            
            
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
