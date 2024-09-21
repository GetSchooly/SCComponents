import SwiftUI

struct PagerIndicatorModifier: ViewModifier {
    
    let currentPageIndicatorTintColor: Color
    let pageIndicatorTintColor: Color
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = currentPageIndicatorTintColor.uiColor
                UIPageControl.appearance().pageIndicatorTintColor = pageIndicatorTintColor.uiColor
            }
    }
}

public extension TabView {
    func indicatorColors(_ currentPage: Color, otherPage: Color) -> some View {
        modifier(PagerIndicatorModifier(currentPageIndicatorTintColor: currentPage, pageIndicatorTintColor: otherPage))
    }
}
