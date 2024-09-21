import SwiftUI
import SCTokens

private extension Text {
    func decorate(with textDecoration: TextDecorationType) -> Text {
        switch textDecoration {
        case .underline:
            self.underline()
        case .lineThrough:
            self.strikethrough()
        case .none:
            self
        }
    }
}

public struct SDText: View {
    
    private let text: Text
    private let style: SDTextStyle
    private let decoration: TextDecorationType
    
    /// Creates a styled text view, wtih optional decoration
    /// - Parameters:
    ///   - content: The string to display.
    ///   - style: The style to apply to the text.
    ///   - decoration: The decoration type applied in addition to the text style.
    public init(_ content: String, style: SDTextStyle, decoration: TextDecorationType = .none) {
        self.text = Text(content).decorate(with: decoration)
        self.style = style
        self.decoration = decoration
    }
    
    public var body: some View {
        text
            .font(style.font)
            .foregroundStyle(style.theme.textColor)
            .multilineTextAlignment(style.textAlignment)
    }
}

#Preview {
    VStack {
        SDText("Creates a styled text view, wtih optional. The style to apply to the text", style: .size200(weight: .regular, theme: .primary, alignment: .leading))
        SDText("Login To continue.", style: .size300(weight: .light, theme: .positive, alignment: .center))
        SDText("The decoration type applied in addition to the text style.", style: .size300(weight: .light, theme: .bright, alignment: .trailing))
    }
}
