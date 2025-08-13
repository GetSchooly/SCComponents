import SwiftUI
import SCTokens

public struct SDBottomList: View {
    private let title: String
    private let items: [String]
    private let onSelect: (Int, String) -> Void
    private let onClose: () -> Void
    
    public init(
        title: String,
        items: [String],
        onSelect: @escaping (Int, String) -> Void,
        onClose: @escaping () -> Void
    ) {
        self.title = title
        self.items = items
        self.onSelect = onSelect
        self.onClose = onClose
    }

    public var body: some View {
        VStack(alignment: .center, spacing: Spacing.spacing0x) {
            titleView

            Divider()
                .foregroundStyle(Color.lightBlue)

            listItemView
        }
        .background(Color.appBackground)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }

    private var titleView: some View {
        HStack {
            Spacer(minLength: Spacing.spacing2x)

            SDText(
                title,
                style: .size300(
                    weight: .semiBold,
                    theme: .primary,
                    alignment: .center
                ),
                decoration: .none
            )
            .padding(.leading, Spacing.spacing10x)

            Spacer(minLength: Spacing.spacing2x)

            Button(action: {
                onClose()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color.black)
                    .padding(Spacing.spacing2x)
            }
            .background(Color.royalBlue10)
            .clipShape(.circle)
            .padding(.trailing, Spacing.spacing4x)
        }
        .padding(.vertical, Spacing.spacing4x)
        .background(Color.appwhite)
    }

    private var listItemView: some View {
        List {
            ForEach(items, id: \.self) { item in
                HStack {
                    SDText(
                        item,
                        style: .size100(
                            weight: .regular,
                            theme: .primary
                        ),
                        decoration: .none
                    )

                    Spacer()

                    SDImage(
                        .local(
                            resource: Icons.ic_NextArrow.value,
                            iconSize: .large
                        )
                    )
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    onSelect(items.firstIndex(of: item) ?? 0, item)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    SDBottomList(
        title: "Select Option",
        items: ["Option 1", "Option 2", "Option 3"]) { _, _ in
        } onClose: { }
}
