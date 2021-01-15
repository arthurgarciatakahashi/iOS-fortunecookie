import Foundation

public protocol Model: Codable {
    
}

public extension Model {
    public func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
