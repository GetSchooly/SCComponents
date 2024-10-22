import SwiftUI
import SCTokens

public struct SDTextField: View {
    @Binding private var text: String
    private let placeholder: String
    
    @Binding private var showError: Bool
    private let errorMessage: String
    private let isSecure: Bool
    
    @FocusState private var isTextFieldFocused: Bool
    
    private var isTextFieldInputChanged: Bool {
        !text.isEmpty || isTextFieldFocused
    }
    
    public init(text: Binding<String>, placeholder: String, showError: Binding<Bool>, errorMessage: String, isSecure: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self._showError = showError
        self.errorMessage = errorMessage
        self.isSecure = isSecure
    }

    public var body: some View {
        VStack(alignment: .leading) {
            VStack {
                ZStack(alignment: .leading) {
                    placeholderView
                    textField
                }
                .frame(minHeight: Sizing.textFieldMinHeight)
            }
            .overlay {
                RoundedRectangle(cornerRadius: Sizing.sizing1x)
                    .stroke(Color.grayStroke, lineWidth: Sizing.sizing0xHalf)
            }
            errorView
        }
    }
    
    private var textField: some View {
        VStack {
            TextField(text: $text, prompt: nil) { }
                .textFieldStyle(SDTextFieldStyle())
                .focused($isTextFieldFocused)
                .onChange(of: isTextFieldFocused, perform: { _ in })
                .onChange(of: text, perform: { value in
                    
                })
        }
        .background(Color.clear)
    }
    
    @ViewBuilder
    private var placeholderView: some View {
        VStack {
            Text(placeholder)
                .foregroundColor(!isTextFieldInputChanged ? Color.placholder : .blackColor)
                .font(!isTextFieldInputChanged ? .font100Regular : .font75Regular)
                .frame(height: !isTextFieldInputChanged ? Sizing.textFieldMinHeight : Sizing.sizing3x)
                .padding(EdgeInsets(top: Sizing.sizing1xHalf, leading: !isTextFieldInputChanged ? Sizing.sizing1x : Sizing.sizing2x, bottom: Sizing.sizing1x, trailing: !isTextFieldInputChanged ? Sizing.sizing1x : Sizing.sizing2x))
                .animation(.linear(duration: 0.3), value: !isTextFieldInputChanged)
            if isTextFieldInputChanged { Spacer() }
        }
    }

    @ViewBuilder
    private var errorView: some View {
        if (text.isEmpty && isTextFieldFocused) || showError {
            Text(errorMessage)
                .frame(alignment: .leading)
                .font(.font75Regular)
                .foregroundColor(Color.error)
                .padding(Spacing.spacing0x)
        }
        EmptyView()
    }
}

struct Usage: View {
    @State private var username: String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        SDTextField(text: $username, placeholder: "Email", showError: $showError, errorMessage: "Enter a valid email", isSecure: false)
    }
}

#Preview {
    Usage()
}
