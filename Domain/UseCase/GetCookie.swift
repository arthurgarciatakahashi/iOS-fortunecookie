import Foundation

public protocol GetCookie {
    func get(completion:  @escaping (Result<CookieModel, DomainError>) -> Void)
}

public struct GetCookieModel: Model {
    public var fortune: String
    
    public init(fortune: String = "") {
        self.fortune = fortune
    }
}

//extension GetCookieModel {
//
//    public func convertFromData(_ data: Data?) -> GetCookieModel? {
//        if let data = data {
//            return try? JSONDecoder().decode(GetCookieModel.self, from: data)
//        } else {
//            return GetCookieModel()
//        }
//     }
//}
