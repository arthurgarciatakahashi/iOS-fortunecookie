import Foundation

public struct CookieModel: Model {
    public var fortune: String
    
    public init(fortune: String = "") {
        self.fortune = fortune
    }
}
