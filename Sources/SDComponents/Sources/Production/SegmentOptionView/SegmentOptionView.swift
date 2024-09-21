import SwiftUI
import SCTokens

public struct SegmentOptionView: View {
    
    private let selectedIndex: Int
    private let items: [String]
    private let onItemTap:(Int) -> ()
    
    @State private var currentSelectedIndex: Int = 0
    
    public init(selectedIndex: Int = 0, items: [String], onItemTap: @escaping (Int) -> ()) {
        self.selectedIndex = selectedIndex
        self.items = items
        self.onItemTap = onItemTap
        self.currentSelectedIndex = selectedIndex
    }
    
    public var body: some View {
        HStack {
            ForEach(0..<items.count, id: \.self) { index in
                SegmentedItemView(model: SegmentedItemModel(title: items[index], index: index)) {
                    currentSelectedIndex = index
                    onItemTap(index)
                }
                .environment(\.currentSelectedIndex, currentSelectedIndex)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: Sizing.sizing2x)
                .stroke(Color.royalBlue, lineWidth: Sizing.sizing0xHalf)
        )
        .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing2x))
    }
}

#Preview {
    SegmentOptionView(items: ["ABC", "XYZ"]) { _ in }
        .frame(width: 300, height: Sizing.sizing12x)
}
