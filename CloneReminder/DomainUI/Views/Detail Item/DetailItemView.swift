import SwiftUI

struct DetailItemView<ViewModel: DetailItemViewModelInterface>: View {
    
    @ObservedObject
    private var model: ViewModel
    
    var body: some View {
        Form {
            Section {
                Group {
                    TextField("Title", text: $model.name)
                        .font(.title)
                        .listRowSeparator(.hidden)
                    TextField("Notes", text: $model.notes)
                }
            }

            Section("Date & Time") {
                HStack {
                    Image(systemName: "calendar")
                    Toggle("Date", isOn: $model.showCalendar)
                }

                if model.showCalendar {
                    DatePicker("",
                               selection: Binding(
                                get: { model.reminderDate ?? .now },
                                set: { model.reminderDate = $0 }),
                               displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .listRowInsets(.all, .zero)
                    .animation(.easeInOut, value: model.showCalendar)
                }

                HStack {
                    Image(systemName: "clock")
                    Toggle("Time", isOn: $model.showTime)
                }
                if model.showTime {
                    DatePicker("",
                               selection: Binding(
                                get: { model.reminderTime ?? .now },
                                set: { model.reminderTime = $0 }),
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
