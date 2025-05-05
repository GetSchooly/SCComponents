import SwiftUI
import SCTokens

public struct SDPickerView: View {
    
    // variables/properties
    @State private var pickerItem: SDPickerModel = .init(id: 0, title: "Sunday")
    
    // your view model
    @ObservedObject var viewModel: SDPickerViewModel
    @Environment(\.dismiss) private var dismiss
    
    public init(title: String? = nil, viewModel: SDPickerViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack {
            VStack {
                Picker(viewModel.pickerTitle ?? "", selection: $pickerItem) {
                    ForEach(viewModel.items, id: \.self) { item in
                        SDText(item.title, style: .size200(weight: .regular, theme: .primary, alignment: .center))
                            .tag(item.id)
                    }
                }
                .onChange(of: pickerItem) { newValue in
                    viewModel.updateSelected(newValue)
                }
            }
            .navigationTitle(viewModel.pickerTitle ?? "")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    SDButton("Done", buttonType: .primaryButton(.size100(weight: .regular, theme: .standard, alignment: .center)), spacing: Spacing.spacing2x) {
                        dismiss()
                    }
                }
            }
            .presentationDetents([.height(220)])
        }
    }
}

#Preview {
    let items: [SDPickerModel] = [
        SDPickerModel(id: 1, title: "Item1"),
        SDPickerModel(id: 2, title: "Item2"),
        SDPickerModel(id: 3, title: "Item3")
    ]
    let viewModel = SDPickerViewModel(items: items) { selected in
        print(selected)
    }
    SDPickerView(viewModel: viewModel).padding()
        .pickerStyle(.wheel)
}
