import SwiftUI

struct AddNewListView<ViewModel: AddNewListViewModelInterface>: View {
    
    @ObservedObject
    var model: ViewModel
    
    private var isFormValid: Bool {
        model.listName.isEmpty
    }
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: model.listIconName)
                    .foregroundStyle(model.color)
                    .font(.system(size: 100))
                TextField("List Name", text: $model.listName)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal, 20)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
            ColorPickerView(selectedColor: $model.color)
                .padding(.leading)
                .padding(.top, 8)
            
            Spacer()
        }
        .padding(.vertical)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("New List")
                    .font(.headline)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    model.cancel()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    model.save()
                }
                .buttonStyle(.bordered)
                .disabled(isFormValid)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddNewListView(
            model: AddNewListViewModel.mock
        )
    }
}
