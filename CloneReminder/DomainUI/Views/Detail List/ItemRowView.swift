import SwiftUI

struct ItemRowView: View {
    
    @Bindable
    private var item: Item
    
    private var color: Color
    
    var body: some View {
        HStack {
            TextField(item.name, text: $item.name)
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
            .init(name: "Milk", isCompleted: false),
            color: .cyan
        )
        ItemRowView(
            .init(name: "Eggs", isCompleted: true),
            color: .red
        )
    }
}
