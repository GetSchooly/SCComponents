import SwiftUI
import SCTokens

public enum SDButtonType {
    case ad(_ textStyle: SDTextStyle = .size75(weight: .regular, theme: .primary, alignment: .center))
    case plain(_ textStyle: SDTextStyle)
    case primaryButton(_ textStyle: SDTextStyle)
    case primaryBordered(_ textStyle: SDTextStyle)
    case secondryBorderd(_ textStyle: SDTextStyle)
    case noStyle(_ textStyle: SDTextStyle = .size100(weight: .regular, theme: .primary, alignment: .leading))
}

struct SDButtonStyle: ButtonStyle {
    private let spacing: CGFloat
    private let buttonType: SDButtonType
    
    init(buttonType: SDButtonType, spacing: CGFloat = Spacing.spacing1x) {
        self.spacing = spacing
        self.buttonType = buttonType
    }

    func makeBody(configuration: Configuration) -> some View {
        switch buttonType {
        case .plain(_), .ad(_):
            PlainButton(spacing: spacing).makeBody(configuration: configuration)
        case .primaryButton(_):
            BlueButton(spacing: spacing).makeBody(configuration: configuration)
        case .primaryBordered(_):
            BlueBorderedButton(spacing: spacing).makeBody(configuration: configuration)
        case .secondryBorderd(_):
            GrayBorderedButton(spacing: spacing).makeBody(configuration: configuration)
        case .noStyle(_):
            NoStyleButton(spacing: spacing).makeBody(configuration: configuration)
        }
    }
}

struct PlainButton: ButtonStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(spacing)
            .background(Color.grayStroke)
            .foregroundStyle(Color.buttonSecondryText)
            .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing2x))
    }
}

struct BlueButton: ButtonStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(spacing)
            .background(Color.primaryBackground)
            .foregroundStyle(Color.buttonPrimaryText)
            .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing2x))
    }
}

struct BlueBorderedButton: ButtonStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(spacing)
            .background(.white)
            .foregroundStyle(Color.buttonSecondryText)
            .overlay(
                RoundedRectangle(cornerRadius: Sizing.sizing2x)
                    .stroke(Color.primaryBorder, lineWidth: Sizing.sizing0xHalf)
            )
    }
}

struct GrayBorderedButton: ButtonStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(spacing)
            .background(.white)
            .foregroundStyle(Color.buttonSecondryText)
            .overlay(
                RoundedRectangle(cornerRadius: Sizing.sizing2x)
                    .stroke(Color.grayStroke, lineWidth: Sizing.sizing0xHalf)
            )
    }
}

struct NoStyleButton: ButtonStyle {
    let spacing: CGFloat
    let forgroundColor: Color = Color.buttonSecondryText
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(spacing)
            .background(.clear)
            .foregroundStyle(forgroundColor)
    }
}

