import Foundation

public protocol GetCookie {
    func get(completion:  @escaping (Result<CookieModel, DomainError>) -> Void)
}

public struct GetCookieModel: Model {
    public var category: String?
    
    public init(category: String? = "") {
        self.category = category
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
