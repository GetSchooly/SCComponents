import SwiftUI

public struct AlertView: ViewModifier {
    
    @ObservedObject var viewModel: AlertViewModel
    
    public func body(content: Content) -> some View {
        content
            .alert(viewModel.title,
                   isPresented: $viewModel.toShow) {
                ForEach(viewModel.actions ?? []) { action in
                    Button(action.title, role: action.role) {
                        action.action()
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                if let message = viewModel.message {
                    Text(message)
                }
            }

    }
}

public extension View {
    func showAlert(_ viewModel: AlertViewModel) -> some View {
        modifier(AlertView(viewModel: viewModel))
    }
}

