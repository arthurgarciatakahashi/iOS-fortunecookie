import Foundation

public protocol GetCookie {
    typealias Result = Swift.Result<CookieModel, DomainError>
    func get(completion:  @escaping (Result) -> Void)
}

public struct GetCookieModel: Model {
    public var category: CategoryType?
    
    public init(category: CategoryType? = nil) {
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
