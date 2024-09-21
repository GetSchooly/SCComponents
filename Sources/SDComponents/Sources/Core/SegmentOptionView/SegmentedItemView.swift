import SwiftUI
import SCTokens

public struct SegmentedItemView: View {

    let model: SegmentedItemModel
    let onItemTap:() -> ()

    @Environment(\.currentSelectedIndex) var currentSelectedIndex
    
    public var body: some View {
        Button {
            onItemTap()
        } label: {
            SDText(model.title, style: .size100(weight: .bold, theme: (currentSelectedIndex == model.index) ? model.textSelectionTheme : .primary, alignment: .center))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background((currentSelectedIndex == model.index) ? model.selectionColor : .clear)
    }
}

public struct SegmentedItemModel {
    let title: String
    let index: Int
    let selectionColor: Color = Color.royalBlue
    let textSelectionTheme: SDTextTheme = .standard
}

private struct SelectedIndexKey: EnvironmentKey {
    static let defaultValue: Int = 0
}

extension EnvironmentValues {
    var currentSelectedIndex: Int {
        get { self[SelectedIndexKey.self] }
        set { self[SelectedIndexKey.self] = newValue }
    }
}
