import Foundation

public protocol GetCookie {
    func get(getCookieModel: GetCookieModel, completion:  @escaping (Result<CookieModel, Error>) -> CookieModel)
}

public struct GetCookieModel: Codable {
    public var fortune: String
    
    public init(fortune: String = "") {
        self.fortune = fortune
    }
}

extension GetCookieModel {
   public func toData() -> Data? {
    return try? JSONEncoder().encode(self)
    }
    
    public func convertFromData(_ data: Data?) -> GetCookieModel? {
        if let data = data {
            return try? JSONDecoder().decode(GetCookieModel.self, from: data)
        } else {
            return GetCookieModel()
        }
     }
}
