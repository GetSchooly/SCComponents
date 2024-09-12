import SwiftUI
import SCTokens

public struct SDButton: View {
    
    private let text: String
    private let buttonType: SDButtonType
    private let spacing: CGFloat
    private let icon: SDImageType?
    private let maxWidth: Bool
    private let onTapAction: (() -> Void)?
    
    public init(_ text: String, buttonType: SDButtonType = .primaryButton(.size100(weight: .regular, theme: .primary, alignment: .center)), spacing: CGFloat = Sizing.sizing1x, icon: SDImageType? = nil, maxWidth: Bool = false, onTapAction: (() -> Void)? = nil) {
        self.text = text
        self.buttonType = buttonType
        self.spacing = spacing
        self.maxWidth = maxWidth
        self.onTapAction = onTapAction
        self.icon = icon
    }
    
    public var body: some View {
        Button(action: {
            onTapAction?()
        }, label: {
            HStack {
                if let icon = icon {
                    SDImage(icon)
                        .foregroundStyle(textStyle.theme.textColor)
                        .padding(EdgeInsets(top: 0, leading: Sizing.sizing1x, bottom: 0, trailing: 0))
                }
                SDText(text, style: textStyle, decoration: .none)
            }
            .modifier(MaxWidth(isNeeded: maxWidth))
        })
        .buttonStyle(SDButtonStyle(buttonType: buttonType, spacing: spacing))
    }
    
    private var textStyle: SDTextStyle {
        switch buttonType {
        case .ad(let textStyle), .plain(let textStyle), .primaryButton(let textStyle), .primaryBordered(let textStyle), .secondryBorderd(let textStyle):
            return textStyle
        }
    }
}

private struct MaxWidth: ViewModifier {
    var isNeeded: Bool
    
    func body(content: Content) -> some View {
        if isNeeded {
            content.frame(minWidth: 0, maxWidth: .infinity)
        } else {
            content
        }
    }
}

#Preview {
    VStack {
        SDButton("Ad", buttonType: .ad())
        SDButton("Button", buttonType: .plain(.size100(weight: .regular, theme: .primary, alignment: .center)))
        SDButton("info", buttonType: .primaryBordered(.size100(weight: .regular, theme: .primarySub, alignment: .center)))
        SDButton("More Info", buttonType: .primaryButton(.size100(weight: .regular, theme: .standard, alignment: .center)))
        SDButton("More Available Information", buttonType: .secondryBorderd(.size100(weight: .regular, theme: .primary, alignment: .center)), spacing: Sizing.sizing2x)
    }
}
