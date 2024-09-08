import SwiftUI
import SCTokens

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
        if case .remote(let url, let placeholder, let scale, let contentMode) = imageType {
            AnyView(remoteImage(url: url, placeholder: placeholder, scale: scale, contentMode: contentMode))
        } else if case .local(let resource, let iconSize, let contentMode) = imageType {
            AnyView(localImage(resource: resource, iconSize: iconSize, contentMode: contentMode))
        }
        EmptyView()
    }
    
    private func remoteImage(url: String, placeholder: String? = nil, scale: CGFloat = 1, contentMode: ContentMode = .fill) -> some View {
        guard let imageURL = URL(string: url) else {
           return AnyView(placeHolderView(placeholder))
        }
        return AnyView(AsyncImage(url: imageURL, scale: scale) { phase in
            if let image = phase.image {
                image.resizable()
                    .aspectRatio(contentMode: contentMode)
            } else { placeHolderView(placeholder) }
        })
    }

    private func placeHolderView(_ placeholder: String? = nil) -> Image {
        return Image(systemName: placeholder ?? "photo.fill")
    }
}

extension SDImage {
    private func localImage(resource: String, iconSize: IconSize = .small, contentMode: ContentMode = .fit) -> some View {
        return VStack(alignment: .center) {
            Image(resource, bundle: nil)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: contentMode)
        }
        .frame(width: iconSize.width, height: iconSize.height)
    }
}
