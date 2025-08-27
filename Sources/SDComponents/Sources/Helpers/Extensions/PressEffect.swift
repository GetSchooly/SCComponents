import SwiftUI

public extension View {
    /// Adds a universal press/touch effect to any view.
    func pressEffect(
        scale: CGFloat = 0.95,
        opacity: Double = 0.7,
        haptic: Bool = true,
        onPress: (() -> Void)? = nil,
        onRelease: (() -> Void)? = nil
    ) -> some View {
        modifier(PressableModifier(scale: scale, opacity: opacity, haptic: haptic, onPress: onPress, onRelease: onRelease))
    }
}

struct PressableModifier: ViewModifier {
    @GestureState private var isPressed = false

    let scale: CGFloat
    let opacity: Double
    let haptic: Bool
    let onPress: (() -> Void)?
    let onRelease: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? scale : 1)
            .opacity(isPressed ? opacity : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: isPressed)
            .contentShape(Rectangle())
            .gesture(
                LongPressGesture(minimumDuration: 0)
                    .updating($isPressed) { _, state, _ in
                        if !state { onPress?(); if haptic { UIImpactFeedbackGenerator(style: .light).impactOccurred() } }
                        state = true
                    }
                    .onEnded { _ in onRelease?() }
            )
    }
}
