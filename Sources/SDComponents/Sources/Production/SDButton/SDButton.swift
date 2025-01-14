import SwiftUI
import SCTokens

public struct SDButton: View {
    
    private let text: String
    private let buttonType: SDButtonType
    private let spacing: CGFloat
    private let icon: SDImageType?
    private let maxSize: Bool
    private let onTapAction: (() -> Void)
    
    public init(_ text: String, buttonType: SDButtonType = .primaryButton(.size100(weight: .regular, theme: .primary, alignment: .center)), spacing: CGFloat = Sizing.sizing1x, icon: SDImageType? = nil, maxSize: Bool = false, onTapAction: @escaping (() -> Void)) {
        self.text = text
        self.buttonType = buttonType
        self.spacing = spacing
        self.maxSize = maxSize
        self.onTapAction = onTapAction
        self.icon = icon
    }
    
    public var body: some View {
        Button(action: {
            onTapAction()
        }, label: {
            HStack {
                if icon?.placement == .left {
                    iconView
                }
                SDText(text, style: textStyle, decoration: .none)
                if icon?.placement == .right {
                    iconView
                }
            }
            .modifier(MaxSize(isNeeded: maxSize))
        })
        .buttonStyle(SDButtonStyle(buttonType: buttonType, spacing: spacing))
    }
    
    @ViewBuilder
    private var iconView: some View {
        if let icon = icon {
            SDImage(icon)
                .foregroundStyle(textStyle.theme.textColor)
                //.padding(EdgeInsets(top: 0, leading: icon.placement == .left ? 0 : 0, bottom: 0, trailing: icon.placement == .left ? Sizing.sizing1x : 0))
        }
    }
    
    private var textStyle: SDTextStyle {
        switch buttonType {
        case .ad(let textStyle), .plain(let textStyle), .primaryButton(let textStyle), .royalBlueBordered(let textStyle), .secondryBorderd(let textStyle), .noStyle(let textStyle), .blackTextSecondryBordered(let textStyle):
            return textStyle
        }
    }
}

private struct MaxSize: ViewModifier {
    var isNeeded: Bool
    
    func body(content: Content) -> some View {
        if isNeeded {
            content.frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            content
        }
    }
}

#Preview {
    VStack {
        SDButton("No Style", buttonType: .noStyle(), onTapAction: {})
        SDButton("Ad", buttonType: .ad(), onTapAction: {})
        SDButton("Button", buttonType: .plain(.size100(weight: .regular, theme: .primary, alignment: .center)), onTapAction: {})
        SDButton("info", buttonType: .royalBlueBordered(.size100(weight: .regular, theme: .primary, alignment: .center)), onTapAction: {})
        SDButton("More Info", buttonType: .primaryButton(.size100(weight: .regular, theme: .standard, alignment: .center)), onTapAction: {})
        SDButton("More Available Information", buttonType: .secondryBorderd(.size100(weight: .regular, theme: .royalBlue, alignment: .center)), spacing: Sizing.sizing2x, onTapAction: {})
        
        SDButton("More Info Fill", buttonType: .primaryButton(.size200(weight: .regular, theme: .standard, alignment: .center)), maxSize: true, onTapAction: {})
            .frame(height: 48)
            .padding()
        
        SDButton("Capsule", buttonType: .blackTextSecondryBordered(.size75(weight: .medium, theme: .primary, alignment: .center)), spacing: Spacing.spacing3x, onTapAction: {})
        
    }
}
