import SwiftUI

struct ScrollViewPagingModifier: ViewModifier {
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
    }
}

public extension ScrollView {
    func enablePaging() -> some View {
        modifier(ScrollViewPagingModifier())
    }
}
