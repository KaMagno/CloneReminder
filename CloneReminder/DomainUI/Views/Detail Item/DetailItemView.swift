import SwiftUI

struct DetailItemView<ViewModel: DetailItemViewModelInterface>: View {
    
    @ObservedObject
    private var model: ViewModel
    
    var body: some View {
        Form {
            Section {
                Group {
                    TextField("Title", text: $model.item.name)
                        .font(.title)
                        .listRowSeparator(.hidden)
                    TextField("Notes", text: Binding($model.item.notes, default: ""))
                }
            }
            
            Section("Date & Time") {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(color(for: model.item))
                    
                    Toggle("Date", isOn: $model.showCalendar)
                }
                
                if model.showCalendar {
                    DatePicker("",
                               selection: Binding(
                                get: { model.item.reminderDate ?? .now },
                                set: { model.item.reminderDate = $0 }),
                               displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .listRowInsets(.all, .zero)
                    .animation(.easeInOut, value: model.showCalendar)
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundStyle(color(for: model.item))
                    
                    Toggle("Time", isOn: $model.showTime)
                }
                if model.showTime {
                    DatePicker("",
                               selection: Binding(
                                get: { model.item.reminderTime ?? .now },
                                set: { model.item.reminderTime = $0 }),
                               displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .listRowInsets(.all, .zero)
                }
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    model.save()
                } label: {
                    Text("Save")
                }
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    model.shouldCancel()
                } label: {
                    Text("Cancel")
                }
                .confirmationDialog(
                    "",
                    isPresented: $model.showCancelConfirmation) {
                        Button("Leave without saving", role: .destructive) {
                            model.cancel()
                        }
                    } message: {
                        Text("Do you want to leave without saving?")
                    }
            }
            
        }
        

    }
    
    init(viewModel: ViewModel) {
        self.model = viewModel
    }
}

private extension DetailItemView {
    func color(for item: Item) -> Color {
        guard let list = item.list,
              let color = Color(hex: list.colorHex) else {
            return .black
        }
        
        return color
    }
}


//MARK: - Preview

#Preview {
    // Provide a sample item and mock model for preview
    let list = ItemsList(
        iconName: "cat",
        name: "Sample Data",
        colorHex: "A81821"
    )
    let sample = Item(
        name: "Sample Title",
        notes: "Some notes",
        reminderDate: .now,
        reminderTime: .now,
        isCompleted: false,
        list: list
    )
    
    NavigationStack {
        DetailItemView(
            viewModel: DetailItemViewModel(
                item: sample,
                dataService: DataService.mock,
                coordinator: MockCoordinator()
            )
        )
    }
}
