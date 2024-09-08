import SCTokens
import SwiftUI

public enum SDTextStyle {
    case size50(weight: SDTextWeight = .regular, theme: SDTextTheme = .standard, alignment: TextAlignment = .leading)
    case size75(weight: SDTextWeight = .regular, theme: SDTextTheme = .standard, alignment: TextAlignment = .leading)
    case size100(weight: SDTextWeight = .regular, theme: SDTextTheme = .standard, alignment: TextAlignment = .leading)
    case size200(weight: SDTextWeight = .regular, theme: SDTextTheme = .standard, alignment: TextAlignment = .leading)
    case size300(weight: SDTextWeight = .regular, theme: SDTextTheme = .standard, alignment: TextAlignment = .leading)
    case size400(weight: SDTextWeight = .regular, theme: SDTextTheme = .standard, alignment: TextAlignment = .leading)
    
    var font: Font {
        switch self {
        case .size50(let weight, _, _):
            font50(weight: weight)
        case .size75(let weight, _, _):
            font75(weight: weight)
        case .size100(let weight, _, _):
            font100(weight: weight)
        case .size200(let weight, _, _):
            font200(weight: weight)
        case .size300(let weight, _, _):
            font300(weight: weight)
        case .size400(let weight, _, _):
            font400(weight: weight)
        }
    }
    
    private func font50(weight: SDTextWeight) -> Font {
        switch weight {
        case .light:
            return Font.font50Light
        case .regular:
            return Font.font50Regular
        case .medium:
            return Font.font50Medium
        case .semiBold:
            return Font.font50SemiBold
        case .bold:
            return Font.font50Bold
        }
    }
    
    private func font75(weight: SDTextWeight) -> Font {
        switch weight {
        case .light:
            return Font.font75Light
        case .regular:
            return Font.font75Regular
        case .medium:
            return Font.font75Medium
        case .semiBold:
            return Font.font75SemiBold
        case .bold:
            return Font.font75Bold
        }
    }
    
    private func font100(weight: SDTextWeight) -> Font {
        switch weight {
        case .light:
            return Font.font100Light
        case .regular:
            return Font.font100Regular
        case .medium:
            return Font.font100Medium
        case .semiBold:
            return Font.font100SemiBold
        case .bold:
            return Font.font100Bold
        }
    }
    
    private func font200(weight: SDTextWeight) -> Font {
        switch weight {
        case .light:
            return Font.font200Light
        case .regular:
            return Font.font200Regular
        case .medium:
            return Font.font200Medium
        case .semiBold:
            return Font.font200SemiBold
        case .bold:
            return Font.font200Bold
        }
    }
    
    private func font300(weight: SDTextWeight) -> Font {
        switch weight {
        case .light:
            return Font.font300Light
        case .regular:
            return Font.font300Regular
        case .medium:
            return Font.font300Medium
        case .semiBold:
            return Font.font300SemiBold
        case .bold:
            return Font.font300Bold
        }
    }
    
    private func font400(weight: SDTextWeight) -> Font {
        switch weight {
        case .light:
            return Font.font400Light
        case .regular:
            return Font.font400Regular
        case .medium:
            return Font.font400Medium
        case .semiBold:
            return Font.font400SemiBold
        case .bold:
            return Font.font400Bold
        }
    }
    
    var theme: SDTextTheme {
        switch self {
        case let .size50(_, theme, _), let .size75(_, theme, _), let .size100(_, theme, _), let .size200(_, theme, _), let .size300(_, theme, _), let .size400(_, theme, _):
            return theme
        }
    }
    
    var textAlignment: TextAlignment {
        switch self {
        case let .size50(_, _, alignment), let .size75(_, _, alignment), let .size100(_, _, alignment), let .size200(_, _, alignment), let .size300(_, _, alignment), let .size400(_, _, alignment):
            return alignment
        }
    }
}

public enum SDTextWeight {
    case light
    case regular
    case medium
    case semiBold
    case bold
}

public enum SDTextTheme {
    case standard
    case primary
    case primarySub
    case secondry
    case positive
    case negative
    case bright
    
    var textColor: Color {
        switch self {
        case .standard:
            return .white
        case .primary:
            return .primaryText
        case .primarySub:
            return .primarySubText
        case .secondry:
            return .secondryText
        case .positive:
            return .green
        case .negative:
            return .red
        case .bright:
            return .orange
        }
    }
}
