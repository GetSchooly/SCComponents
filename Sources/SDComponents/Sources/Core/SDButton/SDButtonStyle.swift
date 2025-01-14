import SwiftUI
import SCTokens

public enum SDButtonType {
    case ad(_ textStyle: SDTextStyle = .size75(weight: .regular, theme: .standard, alignment: .center))
    case plain(_ textStyle: SDTextStyle)
    case primaryButton(_ textStyle: SDTextStyle)
    case royalBlueBordered(_ textStyle: SDTextStyle)
    case secondryBorderd(_ textStyle: SDTextStyle)
    case noStyle(_ textStyle: SDTextStyle = .size100(weight: .regular, theme: .primary, alignment: .leading))
    case blackTextSecondryBordered(_ textStyle: SDTextStyle)
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
        case .royalBlueBordered(_):
            BlueBorderedButton(spacing: spacing).makeBody(configuration: configuration)
        case .secondryBorderd(_):
            GrayBorderedButton(spacing: spacing).makeBody(configuration: configuration)
        case .noStyle(_):
            NoStyleButton(spacing: spacing).makeBody(configuration: configuration)
        case .blackTextSecondryBordered(_):
            BlackTextGreyStrokeBorderedButton(spacing: spacing).makeBody(configuration: configuration)
        }
    }
}

struct PlainButton: ButtonStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(spacing)
            .background(configuration.isPressed ? Color.black.opacity(0.7) : Color.grayStroke)
            .foregroundStyle(Color.lightGray)
            .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing2x))
    }
}

struct BlueButton: ButtonStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(spacing)
            .background(configuration.isPressed ? Color.black.opacity(0.7) : Color.royalBlue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: Sizing.sizing2x))
    }
}

struct BlueBorderedButton: ButtonStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(spacing)
            .background(configuration.isPressed ? Color.black.opacity(0.7) : .white)
            .foregroundStyle(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: Sizing.sizing2x)
                    .stroke(Color.royalBlue, lineWidth: Sizing.sizing0xHalf)
            )
    }
}

struct GrayBorderedButton: ButtonStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(spacing)
            .background(configuration.isPressed ? Color.black.opacity(0.7) : .white)
            .foregroundStyle(Color.royalBlue)
            .overlay(
                RoundedRectangle(cornerRadius: Sizing.sizing2x)
                    .stroke(Color.grayStroke, lineWidth: Sizing.sizing0xHalf)
            )
    }
}

struct NoStyleButton: ButtonStyle {
    let spacing: CGFloat
    let forgroundColor: Color = Color.white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(spacing)
            .background(.clear)
            .foregroundStyle(forgroundColor)
    }
}

struct BlackTextGreyStrokeBorderedButton: ButtonStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, spacing)
            .padding(.vertical, spacing/2)
            .background(configuration.isPressed ? Color.lightBlue : .white)
            .foregroundStyle(configuration.isPressed ? Color.royalBlue : .black)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(configuration.isPressed ? Color.royalBlue : Color.grayStroke, lineWidth: Sizing.sizing0xQuarter)
            )
            .clipShape(.capsule(style: .continuous))
        
    }
}
