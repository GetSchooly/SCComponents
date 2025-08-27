import SwiftUI
import SCTokens
import Kingfisher

public struct SDImage: View {
    private let imageType: SDImageType

    public init(_ load: SDImageType) {
        self.imageType = load
    }

    public var body: some View {
        setImage()
    }

    @ViewBuilder
    private func setImage() -> some View {
        if case .remote(let url, let placeholder, let scale, let contentMode, _) = imageType {
            AnyView(remoteImage(url: url, placeholder: placeholder, scale: scale, contentMode: contentMode))
        } else if case .local(let resource, let iconSize, let contentMode, _) = imageType {
            AnyView(localImage(resource: resource, iconSize: iconSize, contentMode: contentMode))
        } else if case .system(let resource, let iconSize, let foregroundColor, let contentMode, _) = imageType {
            AnyView(systemIcon(resource: resource, iconSize: iconSize, foregroundColor: foregroundColor, contentMode: contentMode))
        }
        EmptyView()
    }

    private func remoteImage(
        url: String,
        placeholder: String? = nil,
        scale: CGFloat = 1,
        contentMode: SwiftUICore.ContentMode = .fill
    ) -> some View {
        guard let imageURL = URL(string: url) else {
            return AnyView(placeHolderView(placeholder, contentMode: contentMode))
        }
        return AnyView(
            KFImage(imageURL)
                .placeholder({
                    placeHolderView(placeholder, contentMode: contentMode)
                })
                .resizable()
                .scaleFactor(scale)
                .aspectRatio(contentMode: contentMode)
        )
    }

    private func placeHolderView(
        _ placeholder: String? = nil,
        contentMode: SwiftUICore.ContentMode = .fill
    ) -> some View {
        guard let placeholder else {
            return Image(Icons.ic_placeholder.value, bundle: AppBundle.scToken.bundle)
                .resizable()
                .aspectRatio(contentMode: contentMode)
        }
        return Image(placeholder)
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
}

extension SDImage {
    private func localImage(
        resource: String,
        iconSize: IconSize = .small,
        contentMode: SwiftUICore.ContentMode = .fit,
        renderingMode: Image.TemplateRenderingMode = .original
    ) -> some View {
        return VStack(alignment: .center) {
            Image(resource, bundle: AppBundle.scToken.bundle)
                .resizable()
                .renderingMode(renderingMode)
                .aspectRatio(contentMode: contentMode)
        }
        .frame(width: iconSize.width, height: iconSize.height)
    }
}

extension SDImage {
    private func systemIcon(
        resource: String,
        iconSize: IconSize = .small,
        foregroundColor: SDTextTheme,
        contentMode: SwiftUICore.ContentMode = .fit
    ) -> some View {
        return VStack(alignment: .center) {
            Image(systemName: resource)
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .foregroundStyle(foregroundColor.textColor)
        }
        .frame(width: iconSize.width, height: iconSize.height)
    }
}
