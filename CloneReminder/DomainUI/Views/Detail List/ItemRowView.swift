import SwiftUI

fileprivate enum Constants {
    enum Image {
        static let emptyName = "circle"
        static let fillName = "circle.fill"
        static let spacing: CGFloat = 4
    }
}

/**
 Shows a Item like row.
 
 # Discussion
 The plan for this Component is to make it work just like a SwiftUI Component.
 For that I used the `EnvironmentKey` and `View` `extension`.
 */
struct ItemRowView: View {
    
    //MARK: Private Properties
    
    @Binding
    private var item: Item
    private var color: Color
    private var onTapDetail: (() -> Void)?
    
    @Environment(\.onToogle)
    private var onToogle: (() -> Void)?
    
    //MARK: Internal Properties
    
    var body: some View {
        HStack {
            buttonFor(isCompleted: item.isCompleted) {
                onToogle?()
            }
            .buttonStyle(.borderless)
            .foregroundStyle(color)
            .padding(.horizontal, Constants.Image.spacing)
            VStack {
                TextField(item.name, text: $item.name)
                noteView(for: item)
                dateDescriptionView(for: item)
            }
            Spacer()
            Button {
                onTapDetail?()
            } label: {
                Image(systemName: "info.circle")
            }
            .buttonStyle(.borderless)
            .foregroundStyle(
                color.mix(with: .black, by: 0.4)
            )
        }
        .background(Color.clear)
    }
    
    init(
        _ item: Binding<Item>,
        color: Color,
        onTapDetail: (() -> Void)? = nil
    ) {
        self._item = item
        self.color = color
        self.onTapDetail = onTapDetail
    }
    
    func onTapDetail(_ action: @escaping () -> Void) -> Self {
        coping(self) {
            $0.onTapDetail = action
        }
    }
}

private extension ItemRowView {
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
    func buttonFor(isCompleted: Bool, action: @escaping () -> Void) -> Button<Image> {
        var imageName: String = Constants.Image.emptyName
        
        if isCompleted {
            imageName = Constants.Image.fillName
        }
        
        return Button {
            action()
        } label: {
            Image(systemName: imageName)
        }
    }
}

/**
A `Environment Key` used to address toogle behavior.
 
 # Discussion
 The `OnToogleKey` is declared `private` because is being used only in `ItemRowView`.
 But it could be `internal` if other Component meets the same behavior.
 */
private struct OnToogleKey: EnvironmentKey {
    static var defaultValue: (() -> Void)? = nil
}

fileprivate extension EnvironmentValues {
    var onToogle: (() -> Void)? {
        get {
            self[OnToogleKey.self]
        }
        set {
            self[OnToogleKey.self] = newValue
        }
    }
}

extension View {
    func onToogle(_ action: @escaping () -> Void ) -> some View {
        environment(\.onToogle, action)
    }
}


//MARK: - Preview

#Preview {
    List {
        ItemRowView(
            .constant(
                .init(name: "Milk",
                      notes: "Must be raw milk",
                      reminderDate: .now,
                      isCompleted: false)
            ),
            color: .cyan
        )
        ItemRowView(
            .constant(
                .init(name: "Eggs",
                      reminderDate: .now.addingTimeInterval(3610*25),
                      isCompleted: true)
            ),
            color: .red
        )
        ItemRowView(
            .constant(
                .init(name: "Eggs",
                      reminderDate: .now.addingTimeInterval(3610*45),
                      isCompleted: false)
            ),
            color: .yellow
        )
    }
}
