import Foundation

public struct CookieModel: Model {
    public var fortune: String
    
    public init(fortune: String = "") {
        self.fortune = fortune
    }
}

extension CookieModel {
    
    public func convertFromData(_ data: Data?) -> CookieModel? {
        if let data = data {
            return try? JSONDecoder().decode(CookieModel.self, from: data)
        } else {
            return CookieModel()
        }
     }
}
