import Foundation

public struct SDPickerModel: Codable, Hashable {
    public let id: Int
    public let year: Int
    public let title: String
    
    public init(id: Int, year: Int, title: String) {
        self.id = id
        self.year = year
        self.title = title
    }
}

