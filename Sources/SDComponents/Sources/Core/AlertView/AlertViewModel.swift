import SwiftUI
import Combine

public class AlertViewModel: ObservableObject {
    @Published public var toShow: Bool = false
    @Published private(set) var title: String = ""
    @Published private(set) var message: String?
    @Published private(set) var actions: [AlertAction]?
    
    public init() {}
    
    public func showAlert(title: String, message: String?, actions: [AlertAction]? = nil) {
        self.title = title
        self.message = message
        self.actions = actions
        toShow = true
    }
}

public struct AlertAction: Identifiable {
    public var id: UUID
    let title: String
    let role: ButtonRole?
    let action: () -> Void
    
    public init(id: UUID = UUID(), title: String, role: ButtonRole? = nil, action: @escaping () -> Void) {
        self.id = id
        self.title = title
        self.role = role
        self.action = action
    }
}
