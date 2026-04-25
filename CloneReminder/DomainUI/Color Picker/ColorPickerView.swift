import SwiftUI

struct ColorPickerView: View {
    
    private enum Constants {
        static let height: CGFloat = 60
        static let circleDiameter: CGFloat = 24
        static let selectionScale: CGSize = .init(width: 1.2, height: 1.2)
    }
    
    @Binding var selectedColor: Color
    
    let colors: [Color] = [
        .green,
        .mint,
        .teal,
        .cyan,
        .blue,
        .indigo,
        .purple,
        .pink,
        .red,
        .orange,
        .yellow,
        .brown,
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(colors, id: \.self) { color in
                    ZStack {
                        Circle()
                            .fill()
                            .foregroundStyle(color)
                            .frame(width: Constants.circleDiameter, height: Constants.circleDiameter)
                            .padding(2)
                        
                        if color == selectedColor {
                            Circle()
                                .stroke(Color.gray, style: .init(lineWidth: 2))
                                .frame(width: Constants.circleDiameter, height: Constants.circleDiameter)
                                .scaleEffect(Constants.selectionScale)
                        }
                        
                    }.onTapGesture {
                        selectedColor = color
                    }
                    
                }
            }
            .frame(maxHeight: .infinity)
        }
        .frame(maxHeight: Constants.height)
        .scrollIndicators(.hidden)
    }
    
    init(selectedColor: Binding<Color> = .constant(.green)) {
        self._selectedColor = selectedColor
    }
}

#Preview {
    ColorPickerView(selectedColor: .constant(.red))
}
