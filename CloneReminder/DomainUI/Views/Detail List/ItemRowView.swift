import SwiftUI

struct ItemRowView: View {
    
    @Bindable
    private var item: Item
    
    private var color: Color
    
    var body: some View {
        HStack {
            VStack {
                TextField(item.name, text: $item.name)
                if let notes = item.notes {
                    Text(notes)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.gray)
                }
                //TODO: Create a logic to replace the date if need to 'Tomorrow'
                if let reminderDate = item.reminderDate {
                    Text(reminderDate.formatted(date: .abbreviated, time: .shortened))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.gray)
                }
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
            .init(name: "Eggs", isCompleted: true),
            color: .red
        )
    }
}
