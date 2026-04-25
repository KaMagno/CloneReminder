import SwiftUI

struct ListRowView: View {
    
    private enum Constants {
        enum Icon {
            static let widht: CGFloat = 32
            static let height: CGFloat = 24
        }
    }
    
    @State
    private var list: ItemsList
    
    var body: some View {
        HStack {
            Image(systemName: list.iconName)
                .frame(width: Constants.Icon.widht, height: Constants.Icon.height)
                .foregroundStyle(list.color)
            Text(list.name)
                .foregroundStyle(list.color)
        }
        
    }
    
    init(list: ItemsList) {
        self.list = list
    }
}

#Preview {
    ListRowView(list: .mock)
}
