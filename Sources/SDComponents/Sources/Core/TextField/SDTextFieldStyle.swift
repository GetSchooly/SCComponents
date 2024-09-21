import SwiftUI
import SCTokens

struct SDTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.font300Regular)
            .foregroundColor(.blackColor)
            .padding(EdgeInsets(top: Spacing.spacing3x,
                                leading: Spacing.spacing2x,
                                bottom: Spacing.spacing0x,
                                trailing: Spacing.spacing2x))
    }
}
