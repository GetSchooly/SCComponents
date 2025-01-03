import SwiftUI
import SCTokens

public enum Placement {
    case left, right
}

public enum SDImageType {
    case local(resource: String, iconSize: IconSize, contentMode: ContentMode = .fit, placement: Placement = .left)
    case remote(url: String, placeholder: String? = nil, scale: CGFloat = 1, contentMode: ContentMode = .fill, placement: Placement = .left)
}

public extension SDImageType {
    var placement: Placement {
        switch self {
        case .local(_, _, _, let placement):
            return placement
        case .remote(_, _, _, _, let placement):
            return placement
        }
    }
}
