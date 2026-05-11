import SwiftUI

struct ItemRowView: View {
    
    @Bindable
    private var item: Item
    
    private var color: Color
    
    var body: some View {
        HStack {
            VStack {
                TextField(item.name, text: $item.name)
                noteView(for: item)
                dateDescriptionView(for: item)
            }
            Spacer()
            imageFor(isCompleted: item.isCompleted)
                .foregroundStyle(color)
        }
    }
    
    init(_ item: Item, color: Color) {
        self.item = item
        self.color = color
    }
    
    //MARK: View Builders
    @ViewBuilder
    func noteView(for item: Item) -> some View {
        if let notes = item.notes {
            Text(notes)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.gray)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    func dateDescriptionView(for item: Item) -> some View {
        if let reminderDate = item.reminderDate {
            Text("\(reminderDate.dueDateDescription), \(reminderDate.dueHourDescription)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.gray)
            
        } else {
            EmptyView()
        }
    }
    
    //MARK: Functions with View as return
    func imageFor(isCompleted: Bool) -> Image {
        var imageName: String = "circle"
        
        if isCompleted {
            imageName = "circle.fill"
        }
        
        return Image(systemName: imageName)
    }
}

#Preview {
    List {
        ItemRowView(
            .init(name: "Milk", notes: "Must be raw milk", reminderDate: .now, isCompleted: false),
            color: .cyan
        )
        ItemRowView(
            .init(name: "Eggs", reminderDate: .now.addingTimeInterval(3610*25), isCompleted: true),
            color: .red
        )
        ItemRowView(
            .init(name: "Eggs", reminderDate: .now.addingTimeInterval(3610*45), isCompleted: false),
            color: .yellow
        )
    }
}
