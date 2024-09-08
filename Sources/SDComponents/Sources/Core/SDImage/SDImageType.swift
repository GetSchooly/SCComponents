import SwiftUI
import SCTokens

public enum SDImageType {
    case local(resource: String, iconSize: IconSize, contentMode: ContentMode = .fit)
    case remote(url: String, placeholder: String? = nil, scale: CGFloat = 1, contentMode: ContentMode = .fill)
}
