import Foundation
import SwiftUI

public class SDPickerViewModel: ObservableObject {
    
    private(set) var pickerTitle: String? = nil
    private(set) var items: [SDPickerModel] = []
    private(set) var selected: (SDPickerModel) -> Void = {_ in }
    
    // MARK:- Initialize
    public init(items: [SDPickerModel], selected: @escaping (SDPickerModel) -> Void) {
        self.items = items
        self.selected = selected
    }
    
    // MARK: - Fetching functions
    func fetchData() {
        // Do something
    }
    
    func updateSelected(_ item: SDPickerModel?) {
        guard let item else { return }
        selected(item)
    }
}
