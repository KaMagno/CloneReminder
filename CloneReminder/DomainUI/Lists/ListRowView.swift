import SwiftUI

struct ListRowView: View {
    
    private enum Constants {
        enum Icon {
            static let widht: CGFloat = 30
            static let height: CGFloat = 30
        }
        enum Text {
            static let leadingPadding: CGFloat = 12
        }
    }
    
    @State
    private var list: ItemsList
    
    var body: some View {
        HStack {
            Image(systemName: list.iconName)
                .resizable()
                .frame(width: Constants.Icon.widht, height: Constants.Icon.height)
                .scaledToFit()
                .foregroundStyle(Color(hex: list.colorHex)!)
            Text(list.name)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundStyle(Color(hex: list.colorHex)!)
                .padding(.leading, Constants.Text.leadingPadding)
        }
    }
    
    init(list: ItemsList) {
        self.list = list
    }
}

#Preview {
    ListRowView(list: .mock)
}
